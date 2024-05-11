import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_flutter/global_controller/socket_controller.dart';
import 'package:iwish_flutter/modules/chat/models/chat_message_response_model.dart';
import 'package:iwish_flutter/modules/chat/models/media_model.dart';
import 'package:iwish_flutter/modules/chat/models/thread_creation_response.dart';
import 'package:iwish_flutter/modules/chat/repository/chat_repository.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/image_picker_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:iwish_flutter/widgets/snackbar_popup.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class ChatController extends GetxController {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final player = AudioPlayer();
  RxString userName = ''.obs;
  TextEditingController chatMsgController = TextEditingController();
  int currentUserId = 0;
  int toUserId = 0;
  RxInt currentIndexPlaying = RxInt(-1);
  RxBool isAudioPlaying = false.obs;
  final SocketController _socketController = Get.find<SocketController>();
  String threadId = '';
  int totalPages = 0;
  int currentPage = 0;
  RxBool emojiShowing = false.obs;
  String? recordingPath;
  RxBool isRecording = false.obs;

  final ChatRepository _chatRepository = ChatRepository();

  RxList<Messages> lstMessageData = <Messages>[].obs;
  RxBool isLoading = false.obs;

  Rx<Duration> totalDuration = Duration.zero.obs;
  Rx<Duration> currentDuration = Duration.zero.obs;
  Duration? currentPosition;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      toUserId = Get.arguments['toUserId'];
      currentUserId = Get.arguments['fromUserId'];
      userName.value = Get.arguments['userName'];

      if (Get.arguments['thread_id'] != null) {
        threadId = Get.arguments['thread_id'];
        debugPrint('chatflow--> $threadId');
      }
      joinRoom(toUserId, currentUserId);
    }

    player.positionStream.listen((position) {
      currentPosition = position;
      currentDuration.value = position;
    });

    player.playerStateStream.listen((event) {
      switch (event.processingState) {
        case ProcessingState.completed:
          player.stop();
          currentIndexPlaying.value = -1;
          isAudioPlaying.value = false;
          currentPosition = null;
          break;
        case ProcessingState.idle:
          debugPrint("idle");
          break;
        case ProcessingState.loading:
          debugPrint("loading");
          break;
        case ProcessingState.buffering:
          debugPrint("buffering");
          break;
        case ProcessingState.ready:
          break;
      }
    });
    super.onInit();
  }

  joinRoom(int toUserId, int currentUserId) {
    Map<String, dynamic> data = {"from_id": currentUserId, "to_id": toUserId};

    _socketController.socket.emitWithAck('create_thread', data,
        ack: (data) async {
      if (data != null) {
        var res = CreateThreadResponse.fromJson(data);
        debugPrint(res.threadId);
        threadId = res.threadId ?? '';
      } else {
        debugPrint('chatflow--> $threadId');
      }
      await requestGetAllMessages(1);
    });
  }

  readMessage(messageId) {
    Map<String, dynamic> data = {
      "thread_id": threadId,
      "read_user_id": currentUserId,
      "sender_user_id": toUserId,
      "message_id": messageId,
    };

    print(toUserId);
    print(currentUserId);

    _socketController.socket.emitWithAck('read_message', data, ack: (data) {
      print("$data");
    });
  }

  sendMessage({List<MessageMedia>? lstMedia}) {
    if (chatMsgController.text.isEmpty && lstMedia == null) {
      return;
    }

    Map<String, dynamic> data = {
      "thread_id": threadId,
      "from_id": currentUserId,
      "to_id": toUserId,
      "message_content":
          chatMsgController.text.isEmpty ? null : chatMsgController.text,
      "message_type": lstMedia != null ? 'media' : 'text',
      "message_media": lstMedia,
    };

    print(data);
    chatMsgController.text = '';
    _socketController.socket.emitWithAck('send_message', data, ack: () {
      print("sent message_ack");
    });
  }

  requestSendMultiMediaMessage(XFile? file, String fileType) async {
    try {
      if (file != null) {
        var res = await _chatRepository
            .uploadMedia(await http.MultipartFile.fromPath('files', file.path));

        print(res.data?.files);
        sendMessage(lstMedia: [
          MessageMedia(name: res.data?.files?.first.key ?? '', type: fileType)
        ]); // res.data.files.first.
      } else {
        throw 'Please select file';
      }
    } catch (e) {
      if (e.toString() == '100') {
        Utils.showNoInternetWarning();
      }
      debugPrint(e.toString());
    }
  }

  addMessageToChatList(dynamic data) {
    print("$data");
    Messages item = Messages.fromJson(data);
    if (item.threadId == threadId) {
      lstMessageData.insert(0, item);
      lstMessageData.refresh();
      if (item.fromId != currentUserId) {
        (item.id);
      }
    }
  }

  updateMessageStatus(dynamic data) {
    if (data['thread_id'] == threadId) {
      lstMessageData
          .firstWhere((element) => element.id == data['message_id'])
          .status = data['status'];
      lstMessageData.refresh();
    }
  }

  //region API Calls
  Future<void> requestGetAllMessages(int pageKey) async {
    isLoading.value = true;

    try {
      var res =
          await _chatRepository.getMessages(threadId, currentUserId, toUserId);

      if (res.data != null &&
          res.data!.messages != null &&
          res.data!.messages!.isNotEmpty) {
        totalPages = res.data!.pagination!.pages!;
        currentPage = res.data!.pagination!.page!;
        lstMessageData.addAll(res.data!.messages!);

        for (int i = 0; i < lstMessageData.length; i++) {
          if (lstMessageData[i].fromId != currentUserId) {
            readMessage(lstMessageData[i].id);
          }
        }

        lstMessageData.refresh();
      } else {}
    } catch (e) {
      e.printError();
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
    } finally {
      isLoading.value = false;
    }
  }

  showSensitiveMsgDialog(data) {
    CustomPopup.showCustomDialog(Get.context!, 'Warning!', data);
  }

  //Region ImagePicker
  void showImagePickerDialog(context) async {
    CustomBottomSheet.showCustomBottomSheet(
        context,
        ImagePickerBottomSheet(
            onPickFromGallary: () => pickFromGallary(),
            onPickFromCamera: () => pickFromCamera()));
  }

  void pickFromGallary() async {
    Get.back();
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );
    if (pickedFile != null) {
      if (Utils.checkIfFileIsImageOrNot(pickedFile)) {
        requestSendMultiMediaMessage(pickedFile, 'image');
      } else {
        SnackbarPopup.show('Only image files are allowed',
            isError: false, title: "Information");
      }
    }
  }

  void pickFromCamera() async {
    Get.back();

    // if (await Permission.camera.isGranted) {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        requestFullMetadata: false,
      );

      if (pickedFile != null) {
        requestSendMultiMediaMessage(pickedFile, 'image');
      }
    } on PlatformException catch (ex) {
      CustomPopup.showCustomDialog(
        Get.context!,
        'Permission denied',
        '${ex.message}',
      );
    }
  }

  //SoundRecordingRegion
  void startRecording() async {
    if (await Permission.microphone.isGranted) {
      final directory = await getTemporaryDirectory();
      final filepath =
          '${directory.path}/iWish-Audio-${DateTime.now().millisecondsSinceEpoch}.rn';
      print(filepath);
      const config = RecordConfig();
      await _audioRecorder.start(config, path: filepath);
      isRecording.value = true;
    } else if (await Permission.microphone.isPermanentlyDenied) {
      openAppSettings();
    } else {
      await Permission.microphone.request();
    }
  }

  void stopRecording() async {
    String? path = await _audioRecorder.stop();
    print('Output path $path');
    isRecording.value = false;
    requestSendMultiMediaMessage(XFile(path!), 'audio');
  }

  void startAndStopRecording(int index) {
    if (isRecording.value) {
      stopRecording();
    } else {
      startRecording();
    }
  }

  //SoundPlayingRegion

  void startPlayingAudio(int index) async {
    if (index == currentIndexPlaying.value) {
      if (player.playing) {
        player.pause();
        isAudioPlaying.value = false;
      } else {
        player.seek(currentPosition);
        player.play();
        isAudioPlaying.value = true;
      }
    } else {
      if (lstMessageData[index].messagesMedia != null &&
          lstMessageData[index].messagesMedia!.isNotEmpty &&
          lstMessageData[index].messagesMedia?.first.name != null &&
          lstMessageData[index].messagesMedia!.first.name!.isNotEmpty) {
        currentIndexPlaying.value = index;
        isAudioPlaying.value = true;
        if (player.playing) {
          player.stop();
        }
        totalDuration.value = await player.setUrl(
                '${APIConfiguration.baseImage}${lstMessageData[index].messagesMedia!.first.name}') ??
            Duration.zero;

        await player.play();
      } else {
        currentIndexPlaying.value = -1;
        isAudioPlaying.value = false;
        if (player.playing) {
          player.stop();
        }
      }
    }
  }

  void stopPlayingAudio() {
    isAudioPlaying.value = false;
    currentIndexPlaying.value = -1;
  }

  //Permission Region
  requestMicroPhonePermission() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      return true;
    } else {
      // Handle permission denied case (e.g., show a dialog)
      return false;
    }
  }
}
