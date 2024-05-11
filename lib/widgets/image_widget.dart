import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/app_assets.dart';

class ImageWidget extends StatelessWidget {
  final String? imagePath;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit? fit;
  final String placeHolderImage;
  final BoxDecoration? boxDecoration;
  const ImageWidget({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
    this.fit,
    required this.borderRadius,
    this.placeHolderImage = AppAssets.icPlaceHolderLarge,
    this.boxDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: boxDecoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
      child: imagePath != null && imagePath!.isNotEmpty
          ? CachedNetworkImage(
              width: width,
              height: height,
              fit: BoxFit.cover,
              imageUrl: '${APIConfiguration.baseImage}$imagePath',
              errorWidget: (context, url, error) => Image.asset(
                placeHolderImage,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
              placeholder: (context, url) => Image.asset(
                placeHolderImage,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            )
          : Image.asset(
              placeHolderImage,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
    );
  }
}
