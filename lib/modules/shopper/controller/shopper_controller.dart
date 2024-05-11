import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/shopper/models/shopper_response_model.dart';
import 'package:iwish_flutter/modules/shopper/repository/shopper_repository.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';

class ShopperController extends GetxController {
  RxBool isMapView = false.obs;
  late GoogleMapController mapController;
  PagingController<int, AllShoppers> pagingController =
      PagingController(firstPageKey: 1);
  final ShopperRepository _repository = ShopperRepository();
  int totalPages = 0;
  int currentPage = 0;

  @override
  void onInit() async {
    await requestGetTrendingWishList(1);
    pagingController.addPageRequestListener((pageKey) async {
      await requestGetTrendingWishList(pageKey);
    });
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //Region API Call
  Future<void> requestGetTrendingWishList(int pageKey,
      {String? searchText}) async {
    try {
      var res = await _repository.getAllShoppers(
        pageKey,
      );
      if (res.data != null &&
          res.data!.allShoppers != null &&
          res.data!.allShoppers!.isNotEmpty) {
        totalPages = res.data!.pagination!.pages!;
        currentPage = res.data!.pagination!.page!;

        final isLastPage = currentPage == totalPages;
        if (isLastPage) {
          pagingController.appendLastPage(res.data!.allShoppers!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(res.data!.allShoppers!, nextPageKey);
        }
      }
    } catch (e) {
      SnackbarPopup.show(e.toString());
    }
  }
}
