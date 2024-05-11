import 'package:get/get.dart';
import 'package:iwish_flutter/global_controller/global_controller.dart';
import 'package:iwish_flutter/global_controller/social_controller.dart';
import 'package:iwish_flutter/global_controller/socket_controller.dart';
import 'package:iwish_flutter/modules/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:iwish_flutter/modules/complete_profile/controller/address_controller.dart';
import 'package:iwish_flutter/modules/complete_profile/controller/complete_account_controller.dart';
import 'package:iwish_flutter/modules/create_a_wish/controller/product_detail_controller.dart';
import 'package:iwish_flutter/modules/add_trip/controller/add_trip_controller.dart';
import 'package:iwish_flutter/modules/home/controller/home_controller.dart';
import 'package:iwish_flutter/modules/interest/controller/interest_controller.dart';
import 'package:iwish_flutter/modules/offers/controller/offers_controller.dart';
import 'package:iwish_flutter/modules/otp/controller/otp_controller.dart';
import 'package:iwish_flutter/modules/otp/controller/otp_email_controller.dart';
import 'package:iwish_flutter/modules/profile/controller/profile_controller.dart';
import 'package:iwish_flutter/modules/shopper/controller/shopper_controller.dart';
import 'package:iwish_flutter/modules/signin/controller/signin_controller.dart';
import 'package:iwish_flutter/modules/splash/controller/splash_controller.dart';
import 'package:iwish_flutter/modules/trending_wishes/controller/trending_wishes_controller.dart';
import 'package:iwish_flutter/modules/trips/controller/trip_detail_controller.dart';
import 'package:iwish_flutter/modules/verification/controller/bank_verification_controller.dart';
import 'package:iwish_flutter/modules/verification/controller/verification_controller.dart';
import 'package:iwish_flutter/modules/view_wish/controller/view_wish_controller.dart';
import 'package:iwish_flutter/modules/wishes/controller/wishes_controller.dart';

class GlobalDependencies extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<SplashController>(
      () => SplashController(),
      fenix: true,
    );
    Get.lazyPut<SignInController>(
      () => SignInController(),
      fenix: true,
    );
    Get.lazyPut<OtpController>(
      () => OtpController(),
      fenix: true,
    );
    Get.lazyPut<BottomNavigationController>(
      () => BottomNavigationController(),
      fenix: true,
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );

    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(),
      fenix: true,
    );
    Get.lazyPut<InterestController>(
      () => InterestController(),
      fenix: true,
    );
    Get.lazyPut<CompleteAccountController>(
      () => CompleteAccountController(),
      fenix: true,
    );
    Get.lazyPut<AddressController>(
      () => AddressController(),
      fenix: true,
    );
    Get.lazyPut<OtpEmailController>(
      () => OtpEmailController(),
      fenix: true,
    );
    Get.lazyPut<TrendingWishesController>(
      () => TrendingWishesController(),
      fenix: true,
    );
    Get.lazyPut<ShopperController>(
      () => ShopperController(),
      fenix: true,
    );
    Get.lazyPut<WishesController>(
      () => WishesController(),
      fenix: true,
    );
    Get.lazyPut<GlobalController>(
      () => GlobalController(),
      fenix: true,
    );
    Get.lazyPut<ViewWishController>(
      () => ViewWishController(),
      fenix: true,
    );
    Get.lazyPut<OffersController>(
      () => OffersController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
    Get.lazyPut<SocialsController>(
      () => SocialsController(),
      fenix: true,
    );
    Get.lazyPut<AddTripController>(
      () => AddTripController(),
      fenix: true,
    );
    Get.lazyPut<TripDetailController>(
      () => TripDetailController(),
      fenix: true,
    );
    Get.lazyPut<VerificationController>(
      () => VerificationController(),
      fenix: true,
    );
    Get.lazyPut<SocketController>(
      () => SocketController(),
      fenix: true,
    );
    Get.lazyPut<BankVerficationController>(
      () => BankVerficationController(),
      fenix: true,
    );
  }
}
