import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iwish_flutter/modules/chat/controller/chat_controller.dart';
import 'package:iwish_flutter/modules/chat/models/chat_message_response_model.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/full_screen_image_viewer.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatScreen extends StatelessWidget {
  static const id = '/ChatScreen';
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: ThemeColors().white,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Obx(() => CustomSecondaryAppBar(
              title: controller.userName.value,
              onBackPressed: () {
                Get.back();
              },
              isBackButtonRequired: true,
              isChatScreen: true,
              onBlockPressed: () {},
              onReportPressed: () {},
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.lstMessageData.length,
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var item = controller.lstMessageData[index];
                  return _chatCell(
                    context,
                    index,
                    item.toId == controller.currentUserId,
                    item,
                    controller,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onTap: () => controller.emojiShowing.value = false,
                        controller: controller.chatMsgController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                          color: ThemeColors().homeTopCardTextColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.saySomething,
                          isDense: true,
                          hintStyle: GoogleFonts.poppins(
                            color: ThemeColors().greyBorder,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        autofocus: false,
                        inputFormatters: const [],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.showImagePickerDialog(context),
                      child: Container(
                        color: ThemeColors().white,
                        width: 20.w,
                        height: 20.h,
                        child: Image.asset(
                          AppAssets.icCamera,
                          width: 20.w,
                          height: 18.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Utils.dismissKeyboard(context);
                        controller.emojiShowing.value =
                            !controller.emojiShowing.value;
                      },
                      child: Container(
                        color: ThemeColors().white,
                        width: 20.w,
                        height: 20.h,
                        child: Image.asset(
                          AppAssets.icEmoji,
                          width: 25.w,
                          height: 20.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onLongPressStart: (details) {
                        controller.startRecording();
                      },
                      onLongPressUp: controller.stopRecording,
                      // onTap: controller.startAndStopRecording,
                      child: Obx(
                        () => AnimatedContainer(
                          duration: const Duration(microseconds: 800),
                          padding: controller.isRecording.value
                              ? EdgeInsets.all(
                                  20.sp,
                                )
                              : EdgeInsets.symmetric(
                                  horizontal: 2.sp, vertical: 6.sp),
                          decoration: BoxDecoration(
                            color: controller.isRecording.value
                                ? ThemeColors().lightRed
                                : ThemeColors().white,
                            shape: controller.isRecording.value
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                          ),
                          child: Image.asset(
                            AppAssets.icMicrophone,
                            width: 13.w,
                            height: 19.h,
                            color: controller.isRecording.value
                                ? ThemeColors().errorRed
                                : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: controller.sendMessage,
                      child: Image.asset(
                        AppAssets.icMsgSend,
                        width: 34.w,
                        height: 34.h,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: ThemeColors().greyBorder,
                ),
              ],
            ),
          ),
          Obx(
            () => Offstage(
              offstage: !controller.emojiShowing.value,
              child: SizedBox(
                child: EmojiPicker(
                  textEditingController: controller.chatMsgController,
                  scrollController: ScrollController(),
                  config: Config(
                    height: 256,
                    emojiViewConfig: EmojiViewConfig(
                      emojiSizeMax: 24 *
                          (foundation.defaultTargetPlatform ==
                                  TargetPlatform.iOS
                              ? 1.0
                              : 1.0),
                    ),
                    swapCategoryAndBottomBar: false,
                    skinToneConfig: const SkinToneConfig(),
                    categoryViewConfig: const CategoryViewConfig(),
                    bottomActionBarConfig: const BottomActionBarConfig(),
                    searchViewConfig: SearchViewConfig(
                        backgroundColor: ThemeColors().primaryColorOne),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatCell(BuildContext context, int index, bool isSender,
      Messages item, ChatController controller) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      margin: EdgeInsets.only(
        left: isSender ? 16.w : Get.width * 0.2,
        right: isSender ? Get.width * 0.2 : 16.w,
        bottom: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        color: isSender
            ? ThemeColors().greyBorder
            : ThemeColors().newCar.withOpacity(0.15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible:
                item.messageContent != null && item.messageContent!.isNotEmpty,
            child: TextWidget(
              text: item.messageContent ?? '',
              color: isSender
                  ? ThemeColors().homeTopCardTextColor
                  : ThemeColors().black,
              fontWeight: FontWeight.w400,
              fontSize: 13.5.sp,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          if (item.messagesMedia != null &&
              item.messagesMedia!.isNotEmpty &&
              item.messagesMedia?.first.type == 'image')
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullScreenImageViewer(
                          '${APIConfiguration.baseImage}${item.messagesMedia?.first.name}')),
                );
              },
              child: ImageWidget(
                imagePath: item.messagesMedia?.first.name ?? '',
                width: 243.w,
                height: 104.23.h,
                fit: BoxFit.fitWidth,
                borderRadius: 8.sp,
              ),
            ),
          if (item.messagesMedia != null &&
              item.messagesMedia!.isNotEmpty &&
              item.messagesMedia?.first.type == 'audio')
            audioWidget(context, item, index, controller),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!isSender)
                Image.asset(
                  item.status == "1"
                      ? AppAssets.icMsgSent
                      : AppAssets.icMsgDelivered,
                  width: 17.w,
                  height: 8.h,
                ),
              const SizedBox(
                width: 4.2,
              ),
              TextWidget(
                // text:
                //     '${Utils.timeDifference(DateTime.parse(item.createdAt ?? DateTime.now().toString()), DateTime.now())} ago',
                text: DateFormat('EE, MMMM dd hh:mm a').format(
                    DateTime.parse(item.createdAt ?? DateTime.now().toString())
                        .toLocal()),
                color: ThemeColors().black,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget audioWidget(BuildContext context, Messages item, int index,
      ChatController controller) {
    return GestureDetector(
      onTap: () => controller.startPlayingAudio(index),
      child: Container(
        // child: Obx(
        //   () => Icon(
        //     controller.isAudioPlaying.value &&
        //             controller.currentIndexPlaying.value == index
        //         ? Icons.pause_circle_outline
        //         : Icons.play_circle_outline,
        //     size: 30.sp,
        //     color: ThemeColors().primaryColorFour,
        //   ),
        // ),
        child: Row(
          children: [
            Obx(
              () => Icon(
                controller.isAudioPlaying.value &&
                        controller.currentIndexPlaying.value == index
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline,
                size: 30.sp,
                color: ThemeColors().primaryColorFour,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => controller.isAudioPlaying.value &&
                            controller.currentIndexPlaying.value == index
                        ? ProgressBar(
                            progress: controller.currentDuration.value,
                            total: controller.totalDuration.value,
                            progressBarColor: ThemeColors().primaryColorOne,
                            baseBarColor: ThemeColors().white,
                            thumbColor: ThemeColors().primaryColorOne,
                            thumbRadius: 2.sp,
                            thumbGlowRadius: 2.sp,
                            barHeight: 3.sp,
                            timeLabelLocation: TimeLabelLocation.sides,
                            timeLabelType: TimeLabelType.remainingTime,
                            timeLabelTextStyle: GoogleFonts.poppins(
                              color: ThemeColors().homeTopCardTextColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          )
                        : TextWidget(
                            text: item.messagesMedia?.first.name ?? '',
                            color: ThemeColors().homeTopCardTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
