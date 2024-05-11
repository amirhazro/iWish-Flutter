import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:iwish_flutter/modules/bottom_navigation/screen/bottom_navigation_screen.dart';
import 'package:iwish_flutter/modules/camera/screen/camera_screen.dart';
import 'package:iwish_flutter/modules/chat/screen/chat_list_screen.dart';
import 'package:iwish_flutter/modules/chat/screen/chat_screen.dart';
import 'package:iwish_flutter/modules/complete_profile/screens/address_screen.dart';
import 'package:iwish_flutter/modules/complete_profile/screens/complete_account_screen.dart';
import 'package:iwish_flutter/modules/complete_profile/screens/profile_image_screen.dart';
import 'package:iwish_flutter/modules/create_a_wish/screens/create_wish_success_screen.dart';
import 'package:iwish_flutter/modules/create_a_wish/screens/product_details_screen.dart';
import 'package:iwish_flutter/modules/create_a_wish/screens/product_summary_screen.dart';
import 'package:iwish_flutter/modules/create_a_wish/screens/select_address_screen.dart';
import 'package:iwish_flutter/modules/add_trip/screens/add_your_trip_screen.dart';
import 'package:iwish_flutter/modules/home/screen/home_screen.dart';
import 'package:iwish_flutter/modules/interest/screen/interest_loading_screen.dart';
import 'package:iwish_flutter/modules/interest/screen/interest_screen.dart';
import 'package:iwish_flutter/modules/more_settings/screen/more_screen.dart';
import 'package:iwish_flutter/modules/offers/screen/offers_screen.dart';
import 'package:iwish_flutter/modules/otp/screen/otp_email_screen.dart';
import 'package:iwish_flutter/modules/otp/screen/otp_screen.dart';
import 'package:iwish_flutter/modules/profile/screens/profile_screen.dart';
import 'package:iwish_flutter/modules/shopper/screen/shopper_screen.dart';
import 'package:iwish_flutter/modules/signin/screen/signin_screen.dart';
import 'package:iwish_flutter/modules/splash/screen/splash_screen.dart';
import 'package:iwish_flutter/modules/static_screens/screens/privacy_policy.dart';
import 'package:iwish_flutter/modules/static_screens/screens/terms_and_condition.dart';
import 'package:iwish_flutter/modules/success/screen/payment_success_screen.dart';
import 'package:iwish_flutter/modules/success/screen/success_screen.dart';
import 'package:iwish_flutter/modules/trending_wishes/screen/trending_wishes_screen.dart';
import 'package:iwish_flutter/modules/trips/screen/trip_detail_screen.dart';
import 'package:iwish_flutter/modules/verification/screen/bank_account_verification_screen.dart';
import 'package:iwish_flutter/modules/verification/screen/verification_screen.dart';
import 'package:iwish_flutter/modules/view_wish/screen/view_wish_screen.dart';
import 'package:iwish_flutter/modules/wishes/screen/wishes_screen.dart';

class Routes {
  static final Routes _sharedInstance = Routes._internal();

  factory Routes() {
    return _sharedInstance;
  }
  Routes._internal();

  //Define Routes Below
  String getSplashPage() => SplashScreen.id;
  String getSignInPage() => SignInScreen.id;
  String getOtpPage() => OTPScreen.id;
  String getBottomNavigationScreen() => BottomNavigationScreen.id;
  String getHomeScreen() => HomeScreen.id;
  String getProductDetailScreen() => ProductDetailScreen.id;
  String getInterestScreen() => InterestScreen.id;
  String getCompleteAccountScreen() => CompleteAccountScreen.id;
  String getProfileImageScreen() => ProfileImageScreen.id;
  String getAddressScreen() => AddressScreen.id;
  String getOtpEmail() => OTPEmailScreen.id;
  String getSuccessScreen() => SuccessScreen.id;
  String getSelectAddressScreen() => SelectAddress.id;
  String getProductSummaryScreen() => ProductSummaryScreen.id;
  String getWishCreationSuccessScreen() => CreateWishSuccessScreen.id;
  String getTrendingWishesScreen() => TrendingWishesScreen.id;
  String getShopperScreen() => ShopperScreen.id;
  String getInterestLoadingScreen() => InterestLoadingScreen.id;
  String getWishesScreen() => WishesScreen.id;
  String getMoreScreen() => MoreScreen.id;
  String getCameraView() => CameraView.id;
  String getViewWishScreen() => ViewWishScreen.id;
  String getOffersScreen() => OffersScreen.id;
  String getProfileScreen() => ProfileScreen.id;
  String getAddTripScreen() => AddYourTripScreen.id;
  String getTripDetailScreen() => TripDetailScreen.id;
  String getVerificationScreen() => VerificationScreen.id;
  String getChatListScreen() => ChatListScreen.id;
  String getChatScreen() => ChatScreen.id;
  String getPrivacyPolicyScreen() => PrivacyPolicyScreen.id;
  String getTermsAndConditionScreen() => TermsAndConditionScreen.id;
  String getPaymentSuccessScreen() => PaymentSuccessScreen.id;
  String getBankAccountVerificationScreen() => BankAccountVerificationScreen.id;

  List<GetPage> routeMap = [
    GetPage(
      name: SplashScreen.id,
      page: () => SplashScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: SignInScreen.id,
      page: () => const SignInScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: OTPScreen.id,
      page: () => const OTPScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: BottomNavigationScreen.id,
      page: () => BottomNavigationScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: HomeScreen.id,
      page: () => const HomeScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: ProductDetailScreen.id,
      page: () => ProductDetailScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: InterestScreen.id,
      page: () => InterestScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: CompleteAccountScreen.id,
      page: () => CompleteAccountScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: ProfileImageScreen.id,
      page: () => ProfileImageScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AddressScreen.id,
      page: () => AddressScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: OTPEmailScreen.id,
      page: () => const OTPEmailScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: SuccessScreen.id,
      page: () => const SuccessScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: SelectAddress.id,
      page: () => SelectAddress(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: ProductSummaryScreen.id,
      page: () => ProductSummaryScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: CreateWishSuccessScreen.id,
      page: () => const CreateWishSuccessScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: TrendingWishesScreen.id,
      page: () => TrendingWishesScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: ShopperScreen.id,
      page: () => ShopperScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: InterestLoadingScreen.id,
      page: () => const InterestLoadingScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: WishesScreen.id,
      page: () => const WishesScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: MoreScreen.id,
      page: () => MoreScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: CameraView.id,
      page: () => const CameraView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: ViewWishScreen.id,
      page: () => ViewWishScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: OffersScreen.id,
      page: () => const OffersScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: ProfileScreen.id,
      page: () => ProfileScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AddYourTripScreen.id,
      page: () => AddYourTripScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: TripDetailScreen.id,
      page: () => TripDetailScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: VerificationScreen.id,
      page: () => const VerificationScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: ChatListScreen.id,
      page: () => ChatListScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: ChatScreen.id,
      page: () => const ChatScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: TermsAndConditionScreen.id,
      page: () => const TermsAndConditionScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: PrivacyPolicyScreen.id,
      page: () => const PrivacyPolicyScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: PaymentSuccessScreen.id,
      page: () => const PaymentSuccessScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: BankAccountVerificationScreen.id,
      page: () => BankAccountVerificationScreen(),
      transition: Transition.cupertino,
    ),
  ];
}
