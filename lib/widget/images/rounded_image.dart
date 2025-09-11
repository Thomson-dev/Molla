import 'package:flutter/material.dart';
import 'package:molla/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool applyImageRadius;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.applyImageRadius = true,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(TSizes.md),
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(TSizes.md),
          child: isNetworkImage 
              ? Image.network(imageUrl, fit: fit) 
              : Image.asset(imageUrl, fit: fit),
        ),
      ),
    );
  }
}