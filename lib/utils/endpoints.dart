class EndPoints {
  //GET
  static const String countryList = "/enrollment/countries";
  static const String getInterestList = "/enrollment/get-interests";
  static const String getLanguages = "/enrollment/get-languages";
  static const String getCities = "/enrollment/get-cities";
  static const String getAddresses = "/enrollment/address-list";
  static const String getHomeData = "/enrollment/dashboard";
  static const String getAllShopper = "/enrollment/all-shoppers";
  static const String getWishes = "/wish/list";
  static const String getWishesDetail = "/wish/view";
  static const String getActiveTrips = "/traveler/trips-list";
  static const String getPastTrips = "/traveler/past-trips";
  static const String getTripDetail = "/traveler/trip-detail-with-wishes";
  static const String getOfferAgainstWish = "/offer/offered-list";
  static const String getIWishServiceFee = "/enrollment/get-service-fee";
  static const String getOffers = "/offer/list";

  //POST
  static const String createUser = "/enrollment/create-user";
  static const String login = "/enrollment/login";
  static const String verifyPhone = "/enrollment/verify-phone";
  static const String resendOtp = "/enrollment/resend-otp";
  static const String validateEmail = "/enrollment/validate-email";
  static const String verifyEmail = "/enrollment/verify-email";
  static const String completeProfile = "/enrollment/complete-profile";
  static const String resendEmailOtp = "/enrollment/resend-email-otp";
  static const String updateProfileImage = "/enrollment/update-picture";
  static const String addUserAddress = "/enrollment/add-user-address";
  static const String createWishApi = "/wish/add-wish";
  static const String trendingWishList = "/wish/trending-wish-list";
  static const String selectInterest = "/enrollment/select-interests";
  static const String updateAWish = "/wish/update-wish";
  static const String changeWishStatus = "/wish/change-wish-status";
  static const String deleteWish = "/wish/delete";
  static const String addTrip = "/traveler/add-trip";
  static const String reviewTravler = "/wish/review";
  static const String reviewWish = "/traveler/review";
  static const String offerStatusChange = "/offer/change-status";
  static const String createOffer = "/offer/create";
  static const String updateOffer = "/offer/update";
  static const String getChatList = "/chat/inbox";
  static const String getChatMessages = "/chat/get-messages";
  static const String uploadChatMedia = "/chat/upload-media";
  static const String signUpWithGoogle = "/enrollment/signup-with-google";
  static const String signUpWithApple = "/enrollment/signup-with-apple";
  static const String signUpWithFaceBook = "/enrollment/signup-with-facebook";

  //PaymentSdkPostEndPoints
  static const String getSdkToken = "/offer/sdk-token";
  static const String paymentSuccess = "/offer/payment-success";
  static const String paymentFailure = "/offer/payment-failure";

  //CurrencyConversionPostEndPoint
  static const String currencyConversion = "/enrollment/currency-converstion";
}
