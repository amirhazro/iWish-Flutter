import 'dart:async';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/chat/controller/chat_controller.dart';
import 'package:iwish_flutter/modules/chat/controller/chat_list_controller.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  late IO.Socket socket;
  Timer? timer;

  @override
  void onInit() {
    initSocketConnection();

    super.onInit();
  }

  void initSocketConnection() async {
    socket = IO.io(
      "https://api-iwish-dev.veroke.com",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableForceNewConnection()
          .setExtraHeaders(
            {
              'access_token':
                  await StorageService().readString(Keys.Auth_Token),
            },
          )
          .build(),
    );

    socket.connect();
    socket.onConnect((data) {
      print('connected');
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
      registerListeners();
    });
    socket.onConnecting((data) => print("socket is connecting"));
    socket.onReconnecting((data) => print("socket is reconnecting"));
    socket.onConnectTimeout((data) => print("socket connect timeout"));
    socket.onConnectError((data) => print('error $data'));
    socket.onDisconnect((data) {
      print('disconnected');
      timer = Timer.periodic(
          const Duration(seconds: 5), (Timer t) => socket.connect());
    });
  }

  registerListeners() {
    socket.off('new_message', newMessgeHandler);
    socket.off('read_receipt', readReceiptHandler);
    socket.off('sensitive_message', readReceiptHandler);

    socket.on('new_message', newMessgeHandler);
    socket.on('read_receipt', readReceiptHandler);
    socket.on('sensitive_message', showSensitiveMsgDialog);
  }

  readReceiptHandler(data) {
    if (Get.isRegistered<ChatController>()) {
      Get.find<ChatController>().updateMessageStatus(data);
    }
  }

  showSensitiveMsgDialog(data) {
    if (Get.isRegistered<ChatController>()) {
      Get.find<ChatController>().showSensitiveMsgDialog(data);
    }
  }

  newMessgeHandler(data) async {
    if (Get.isRegistered<ChatController>()) {
      Get.find<ChatController>().addMessageToChatList(data);
    } else if (Get.isRegistered<ChatListController>()) {
      Get.find<ChatListController>().reloadChatList();
    }
  }

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }
}
