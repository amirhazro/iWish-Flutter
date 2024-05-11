import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:intl/intl.dart';
import 'package:iwish_flutter/modules/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:iwish_flutter/modules/complete_profile/models/city_view_model.dart';
import 'package:iwish_flutter/modules/complete_profile/repository/complete_profile_repository.dart';
import 'package:iwish_flutter/modules/add_trip/repository/add_trip_repository.dart';
import 'package:iwish_flutter/modules/trips/controller/trips_controller.dart';
import 'package:iwish_flutter/modules/trips/models/trips_model.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/widgets/trip_added_conformation_bottom_sheet_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTripController extends GetxController {
  final AddTripRepository _repository = AddTripRepository();

  RxBool isLoading = false.obs;
  RxBool isRoundTrip = false.obs;
  RxBool isCityLoading = false.obs;
  RxBool noCityDataAvailable = false.obs;

  RxString selectedFromCity =
      AppLocalizations.of(Get.context!)!.enterCityName.obs;
  RxString selectedToCity =
      AppLocalizations.of(Get.context!)!.enterCityName.obs;
  RxString selectedToFlag = ''.obs;
  RxString selectedFromFlag = ''.obs;

  RxString selectedDate = ''.obs;
  RxString selectedYear = ''.obs;
  DateTime? departureDate, returnDate;

  bool isVerifiedFlow = false;

  Rx<PickerDateRange?> initialDateRange = Rx<PickerDateRange?>(null);
  Rx<DateTime?> initialSelectedDate = Rx<DateTime?>(null);

  int? fromCityId, toCityId, fromCountryId, toCountryId;

  int? tripId;

  var debouncer = Debouncer(delay: const Duration(seconds: 1));

  TextEditingController cityNameController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  RxString searchHint = "Search city".obs;
  RxList<CityViewModel> lstCityData = <CityViewModel>[].obs;

  @override
  void onInit() async {
    await requestFetchCityData();

    if (Get.arguments != null && Get.arguments['item'] != null) {
      Trips trip = Trips.fromJson(Get.arguments['item']);

      tripId = trip.id;
      fromCityId = trip.fromCityid;
      toCityId = trip.toCityid;
      fromCountryId = trip.fromCountryid;
      toCountryId = trip.toCountryid;

      if (trip.tripType == 'one_way') {
        isRoundTrip.value = false;
        departureDate = DateTime.parse(trip.departureDate!);
        initialSelectedDate.value = DateTime.parse(trip.departureDate!);
        selectedDate.value =
            DateFormat('MMM dd').format(DateTime.parse(trip.departureDate!));
        selectedYear.value =
            DateFormat('yyyy').format(DateTime.parse(trip.departureDate!));
      } else {
        isRoundTrip.value = true;
        initialDateRange.value = PickerDateRange(
            DateTime.parse(trip.departureDate!),
            DateTime.parse(trip.returnDate!));

        selectedDate.value =
            '${DateFormat('MMM dd').format(DateTime.parse(trip.departureDate!))} ~ ${DateFormat('MMM dd').format(DateTime.parse(trip.returnDate!))}';

        if (DateFormat('yyyy').format(DateTime.parse(trip.departureDate!)) ==
            DateFormat('yyyy').format(DateTime.parse(trip.returnDate!))) {
          selectedYear.value =
              DateFormat('yyyy').format(DateTime.parse(trip.departureDate!));
        } else {
          selectedYear.value =
              '${DateFormat('yyyy').format(DateTime.parse(trip.departureDate!))} ~ ${DateFormat('yyyy').format(DateTime.parse(trip.returnDate!))}';
        }

        departureDate = DateTime.parse(trip.departureDate!);
        returnDate = DateTime.parse(trip.returnDate!);
      }

      selectedFromCity.value =
          '${trip.fromCity?.name}, ${trip.fromCity?.countryCode}';
      selectedToCity.value =
          '${trip.toCity?.name}, ${trip.toCity?.countryCode}';
      selectedToFlag.value = trip.toCity?.countriesMaster?.emoji ?? '';
      selectedFromFlag.value = trip.fromCity?.countriesMaster?.emoji ?? '';
    }

    if (Get.arguments != null && Get.arguments['isVerifiedFlow'] != null) {
      isVerifiedFlow = Get.arguments['isVerifiedFlow'] ?? false;
    }

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        searchHint.value = '';
      } else {
        searchHint.value = 'Search city';
      }
    });

    cityNameController.addListener(() {
      if (cityNameController.text.length < 3) return;
      debouncer.call(() {
        requestFetchCityData();
      });
    });
    super.onInit();
  }

  //region API Call

  Future<void> requestFetchCityData() async {
    if (lstCityData.isNotEmpty) {
      lstCityData.clear();
      lstCityData.refresh();
    }
    isCityLoading.value = true;
    try {
      var res = await CompleteProfileRepository().getCityData(
        cityNameController.text,
      );
      if (res.isNotEmpty) {
        noCityDataAvailable.value = false;
        lstCityData.addAll(res);
        lstCityData.refresh();
      } else {
        noCityDataAvailable.value = true;
      }
    } catch (e) {
      e.printError();
      rethrow;
    } finally {
      isCityLoading.value = false;
    }
  }

  showTripAddedBottomSheet(BuildContext context) {
    String titleText;
    String descriptionText;
    if (isVerifiedFlow) {
      titleText = AppLocalizations.of(context)!.youreVarified;
      descriptionText = AppLocalizations.of(context)!.varifiedAddedWish;
    } else {
      titleText = "Success";
      descriptionText = "Your trip has been added successfully.";
    }

    CustomBottomSheet.showCustomBottomSheet(
      context,
      modalColor: ThemeColors().white,
      WillPopScope(
        onWillPop: () {
          return Future<bool>.value(false);
        },
        child: TripAddedConfirmation(
          onConfirm: () {
            Get.back();
            Get.back();
            Get.find<BottomNavigationController>().changeTabIndex(1);
            if (Get.isRegistered<TripsController>()) {
              Get.find<TripsController>().requestGetTripList();
            }
          },
          onCrossPressed: () {
            Get.back();
            Get.back();
          },
          titleText: titleText,
          descriptionText: descriptionText,
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.9,
      ),
      enableDrag: false,
    );
  }

  Future<void> requestPostTripData() async {
    if ((fromCityId == null && fromCountryId == null) ||
        (toCityId == null && toCountryId == null)) {
      CustomPopup.showCustomDialog(Get.context!, "Missing information",
          "Please select both the origin and destination cities to ensure accurate trip planning and information.");
      return;
    }

    if (departureDate == null) {
      CustomPopup.showCustomDialog(
          Get.context!,
          "Missing information",
          isRoundTrip.value
              ? 'Ensure that you select both the departure and return date to proceed with planning your round trip.'
              : 'Choosing a departure date is necessary for scheduling your trip.');
      return;
    }
    if (isRoundTrip.value && returnDate == null) {
      CustomPopup.showCustomDialog(Get.context!, "Missing information",
          'Ensure that you select both the departure and return date to proceed with planning your round trip.');
      return;
    }

    String tripType = 'one_way';
    if (isRoundTrip.value) {
      tripType = 'round';
    }

    isLoading.value = true;

    try {
      var res = await _repository.postTripData(
        tripType,
        '$fromCityId',
        '$toCityId',
        departureDate!,
        '$fromCountryId',
        '$toCountryId',
        returnDate: returnDate,
      );

      if (res.data != null) {
        showTripAddedBottomSheet(Get.context!);
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }
}
