import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_flutter/helper/dependencies.dart';
import 'package:iwish_flutter/modules/splash/screen/splash_screen.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GlobalDependencies().dependencies();

  bool checkIfUserLoggedIn =
      await StorageService().readString(Keys.Auth_Token) != null;
  int? checkIfUserHasInterestAdded =
      await StorageService().readInt(Keys.UserInterest);

  String? locale = await StorageService().readString(Keys.locale);
  locale ??= "en";

  runApp(MyApp(
    isAlreadyLogin: checkIfUserLoggedIn,
    isInterestAdded: checkIfUserHasInterestAdded,
    language: Locale(locale),
  ));
}

class MyApp extends StatefulWidget {
  final bool? isAlreadyLogin;
  final int? isInterestAdded;
  final Locale? language;
  const MyApp(
      {super.key, this.isAlreadyLogin, this.language, this.isInterestAdded});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _listener;
  var initialRoute = SplashScreen.id;

  @override
  void initState() {
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
    // _fetchLocale();
    super.initState();
  }

  // Listen to the app lifecycle state changes
  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
    }
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 836),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          /* debugShowCheckedModeBanner: false,
          initialRoute: widget.isAlreadyLogin ?? false
              ? widget.isInterestAdded == 1
                  ? Routes().getBottomNavigationScreen()
                  : Routes().getInterestScreen()
              : initialRoute,*/
          initialRoute: Routes().getBottomNavigationScreen(),
          defaultTransition: Transition.fadeIn,
          getPages: Routes().routeMap,
          title: 'iWish',
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (
            locale,
            supportedLocales,
          ) {
            return locale;
          },
          locale: widget.language,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            useMaterial3: true,
            textTheme: Get.locale?.languageCode == 'en'
                ? GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme,
                  )
                : GoogleFonts.cairoTextTheme(
                    Theme.of(context).textTheme,
                  ),
            bottomSheetTheme: const BottomSheetThemeData(
              surfaceTintColor: Colors.white,
            ),
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(0.9)),
              child: child!,
            );
          },
        );
      },
    );
  }

  void _fetchLocale() async {
    String languageCode =
        await StorageService().readString(Keys.locale) ?? 'en';
    Get.updateLocale(Locale(languageCode));
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
