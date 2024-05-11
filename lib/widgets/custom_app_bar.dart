import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class HomeAppBar extends StatelessWidget {
  final String? userName;
  final String? imagePath;
  final VoidCallback? onChatPressed;
  const HomeAppBar({
    super.key,
    this.userName,
    this.imagePath,
    this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return homeAppBarWidget(context, userName);
  }

  Widget homeAppBarWidget(BuildContext context, String? name) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 101.sp,
      decoration: BoxDecoration(
        color: ThemeColors().white,
      ),
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 31.sp),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                  text: name ?? "",
                  color: ThemeColors().black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          InkWell(
            onTap: onChatPressed,
            child: Container(
              color: ThemeColors().white,
              width: 22.w,
              height: 22.h,
              child: Image.asset(
                AppAssets.icChat,
                width: 22.w,
                height: 22.h,
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          InkWell(
            onTap: () {},
            child: SizedBox(
              width: 22.w,
              height: 22.h,
              child: Image.asset(
                AppAssets.icNotification,
                width: 22.w,
                height: 22.h,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                20.sp,
              ),
              child: imagePath != null && imagePath!.isNotEmpty
                  ? CachedNetworkImage(
                      width: 41.sp,
                      height: 41.sp,
                      fit: BoxFit.cover,
                      imageUrl: '${APIConfiguration.baseImage}$imagePath',
                      errorWidget: (context, url, error) => Image.asset(
                        AppAssets.icUserPlaceholder,
                        width: 41.w,
                        height: 41.h,
                        fit: BoxFit.cover,
                      ),
                      placeholder: (context, url) => Image.asset(
                        AppAssets.icUserPlaceholder,
                        width: 41.w,
                        height: 41.h,
                        fit: BoxFit.cover,
                        color: ThemeColors().dimGray,
                      ),
                    )
                  : Image.asset(
                      AppAssets.icUserPlaceholder,
                      width: 41.sp,
                      height: 41.sp,
                      color: ThemeColors().dimGray,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
