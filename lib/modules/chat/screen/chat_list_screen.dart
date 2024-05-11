import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/chat/controller/chat_list_controller.dart';
import 'package:iwish_flutter/modules/chat/models/chat_list_response_model.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';

import '../../../widgets/loading_indicator.dart';

class ChatListScreen extends StatelessWidget {
  static const id = '/ChatListScreen';
  final controller = Get.put(ChatListController());
  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors().white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomSecondaryAppBar(
          title: AppLocalizations.of(context)!.chat,
          onBackPressed: () {
            Get.back();
          },
          isBackButtonRequired: true,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.sp),
            width: Get.width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ThemeColors().greyUnderline,
                  width: 1.sp,
                ),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  40.w,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.sp, right: 20.sp),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      style: TextStyle(
                        color: ThemeColors().homeTopCardTextColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      obscureText: false,
                      decoration: InputDecoration(
                        icon: Image.asset(
                          AppAssets.icSearch,
                          width: 20.w,
                          height: 20.h,
                          color: ThemeColors().graniteGray,
                        ),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!.searchHere,
                        isDense: true,
                        hintStyle: TextStyle(
                            color: ThemeColors().homeTopCardTextColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      autofocus: false,
                      inputFormatters: [
                        RemoveEmojiInputFormatter(),
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9\-()_\'\‘\’ ]")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PagedListView(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<Conversations>(
                itemBuilder: (context, item, index) {
                  return GestureDetector(
                    onTap: () async => controller.navToChatScreen(
                        item.lastMessage?.threadId ?? '',
                        item.otherUser?.id ?? 0,
                        await StorageService().readInt(Keys.UserId) ?? 0,
                        '${item.otherUser?.firstName ?? ''} ${item.otherUser?.lastName ?? ''}'),
                    child: _listItem(item, index),
                  );
                },
                firstPageProgressIndicatorBuilder: (context) =>
                    const LoadingIndicator(),
                newPageProgressIndicatorBuilder: (context) =>
                    const LoadingIndicator(),
                noItemsFoundIndicatorBuilder: (context) => Center(
                  child: TextWidget(
                    text: "No chats available",
                    color: ThemeColors().homeTopCardTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _listItem(Conversations item, index) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      width: Get.width,
      decoration: BoxDecoration(
        color: index == 0 || index == 1
            ? ThemeColors().white
            : ThemeColors().white,
        border: Border(
          bottom: BorderSide(
            color: ThemeColors().greyUnderline,
            width: 1.sp,
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            40.w,
          ),
        ),
      ),
      child: Row(
        children: [
          ImageWidget(
            imagePath: item.otherUser?.picture ?? '',
            width: 44.w,
            height: 44.h,
            fit: BoxFit.cover,
            borderRadius: 0.sp,
            placeHolderImage: AppAssets.icPlaceHolderSmall,
            boxDecoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text:
                          '${item.otherUser?.firstName ?? ''} ${item.otherUser?.lastName ?? ''}',
                      color: ThemeColors().black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                    TextWidget(
                      text: Utils.timeDifference(
                          DateTime.parse(item.lastMessage?.createdAt ??
                              DateTime.now().toString()),
                          DateTime.now()),
                      color: ThemeColors().black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: item.lastMessage?.messageType == 'text'
                          ? item.lastMessage?.messageContent ?? ''
                          : 'Attachment received',
                      color: ThemeColors().black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                    if (item.lastMessage?.unread != null &&
                        item.lastMessage?.unread != 0)
                      Container(
                        decoration: BoxDecoration(
                          color: ThemeColors().errorRed,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(6.sp),
                        child: TextWidget(
                          text: '${item.lastMessage?.unread ?? 0}',
                          color: ThemeColors().white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
