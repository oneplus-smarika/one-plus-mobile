import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../text/custom_text.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fitStatus;
  final String? errorImage;
  final String? intials;
  final double? size;
  final double? height;
  final double? width;
  final Widget? errorWidget;

  const CustomCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.size,
    this.height,
    this.width,
    this.fitStatus,
    this.errorImage,
    this.errorWidget,
    this.intials,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double? finalHeight = height ?? size;
    final double? finalWidth = width ?? size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        height: finalHeight,
        width: finalWidth,
        imageUrl: imageUrl ?? '',
        fit: fitStatus ?? BoxFit.fill,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => errorWidget ??
            CircleAvatar(
              radius: 70,
              backgroundColor: AppColors.mainColor,
              child: CText(
                intials ?? '',
                type: TextType.headlineLarge,
                // fontSize: 48,
                color: AppColors.white,),
            ),
      ),
    );
  }
}
