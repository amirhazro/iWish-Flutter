import 'package:get/get.dart';
import 'package:iwish_flutter/modules/interest/models/interst_chip_modal.dart';
import 'package:iwish_flutter/modules/interest/repository/interest_repository.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/routes.dart';

class InterestController extends GetxController {
  RxList<InterestChipModal> lstInterestData = <InterestChipModal>[].obs;
  RxBool isLoading = false.obs;

  final InterestRepository _repository = InterestRepository();

  @override
  void onInit() {
    requestGetInterestList();

    super.onInit();
  }

  void handleSelection(InterestChipModal element) {
    int index = lstInterestData.indexOf(element);
    lstInterestData[index].isSelected.value =
        !lstInterestData[index].isSelected.value;
  }

  void requestGetInterestList() async {
    isLoading.value = true;
    try {
      var res = await _repository.getInterestList();

      lstInterestData.addAll(res);
      lstInterestData.refresh();
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  void requestPostUserInterest() async {
    if (lstInterestData.where((p0) => p0.isSelected.value).isEmpty) {
      CustomPopup.showCustomDialog(Get.context!, "Information",
          "Please select atleast one interest before proceeding to next screen.",
          buttonText: "Ok");
      return;
    }

    String ids = lstInterestData
        .where((element) => element.isSelected.value)
        .map((obj) => obj.id)
        .join(', ');

    isLoading.value = true;
    try {
      var res = await _repository.postAddInterest(ids);

      if (res.statusCode == 200) {
        await StorageService().writeInt(Keys.UserInterest, 1);
        Get.toNamed(Routes().getInterestLoadingScreen());
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }
}
