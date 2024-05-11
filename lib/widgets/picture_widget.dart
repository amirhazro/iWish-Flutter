import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwish_flutter/utils/app_assets.dart';

class PictureNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  const PictureNetworkWidget(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20.sp) // Adjust the radius as needed
          ),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        errorWidget: (context, url, error) => Image.asset(
          AppAssets.icPlaceHolderSmall,
        ),
        placeholder: (context, url) => Image.asset(
          AppAssets.icPlaceHolderSmall,
        ),
      ),
    );
  }
}
