import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/chat/models/chat_list_response_model.dart';
import 'package:iwish_flutter/modules/chat/repository/chat_repository.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';

class ChatListController extends GetxController {
  RxBool isLoading = false.obs;

  final ChatRepository _repository = ChatRepository();
  PagingController<int, Conversations> pagingController =
      PagingController(firstPageKey: 1);
  int totalPages = 0;
  int currentPage = 1;

  Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 600));

  @override
  void onInit() async {
    await requestGetAllChats(1);
    pagingController.addPageRequestListener((pageKey) async {
      await requestGetAllChats(pageKey);
    });
    super.onInit();
  }

  void navToChatScreen(
      String threadId, int toId, int fromId, String userName) async {
    await Get.toNamed(Routes().getChatScreen(), arguments: {
      'thread_id': threadId,
      'toUserId': toId,
      'fromUserId': fromId,
      'userName': userName,
    });
    pagingController.itemList?.clear();
    await requestGetAllChats(1);
  }

  reloadChatList() {
    debouncer.call(() {
      Get.find<ChatListController>().pagingController.itemList?.clear();
      Get.find<ChatListController>().requestGetAllChats(1);
    });
  }

  //region API Call

  Future<void> requestGetAllChats(int pageKey) async {
    isLoading.value = true;

    try {
      var res = await _repository.getChatListData();

      if (res.data != null &&
          res.data!.conversations != null &&
          res.data!.conversations!.isNotEmpty) {
        totalPages = res.data!.pagination!.pages!;
        currentPage = res.data!.pagination!.page!;

        final isLastPage = currentPage == totalPages;
        if (isLastPage) {
          pagingController.appendLastPage(res.data!.conversations!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(res.data!.conversations!, nextPageKey);
        }
      } else {
        pagingController.appendPage([], 1);
      }
    } catch (e) {
      pagingController.appendPage([], 1);
      e.printError();
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      } else {
        SnackbarPopup.show(e.toString(), isError: true);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
