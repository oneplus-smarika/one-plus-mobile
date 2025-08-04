// import 'package:flutter/material.dart';
// import 'package:notice_park/core/utils/ui_helpers/app_spacing.dart';
// import '../../constants/app_colors.dart';
// import '../text/custom_text.dart';
//
// class ReusableButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color? backgroundColor;
//   final Gradient? backgroundGradient;
//   final TextStyle? textStyle;
//   final Color? borderColor;
//   final Color? textColor;
//   final double? borderWidth;
//   final FontWeight? fontWeight;
//   final Widget? btnIcon;
//   final Widget? suffixIcon;
//   final TextType? textType;
//   final double? borderRadius;
//   final double? verticalBtnHeight;
//   final BorderRadius? borderRadiusCust;
//   final MainAxisAlignment? alignmentForText;
//   final bool isLoading;
//
//
//   const   ReusableButton({
//     Key? key,
//     required this.text,
//     required this.onPressed,
//     this.backgroundColor,
//     this.backgroundGradient,
//     this.textStyle,
//     this.borderColor,
//     this.textColor,
//     this.borderWidth,
//     this.btnIcon,
//     this.textType,
//     this.fontWeight,
//     this.suffixIcon,
//     this.borderRadius,
//     this.borderRadiusCust,
//     this.alignmentForText,
//     this.verticalBtnHeight,
//     this.isLoading = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: isLoading ? null : onPressed,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//             vertical: verticalBtnHeight ?? 8.0, horizontal: 8.0),
//         decoration: BoxDecoration(
//           color: backgroundColor ?? AppColors.mainColor,
//           gradient: backgroundGradient,
//           borderRadius:
//           borderRadiusCust ?? BorderRadius.circular(borderRadius ?? 8.0),
//           border: Border.all(
//             color: borderColor ?? Colors.transparent,
//             width: borderWidth ?? 0.0,
//           ),
//         ),
//         child: Center(
//           child: isLoading
//               ? CircularProgressIndicator(  color: textColor ?? AppColors.white,)
//               : Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: alignmentForText == null ? 16.0 : 0.0,
//               vertical: 4.0,
//             ),
//             child: Row(
//               mainAxisAlignment: alignmentForText ?? MainAxisAlignment.center,
//               children: [
//                 btnIcon ?? const SizedBox.shrink(),
//                 alignmentForText == null
//                     ? AppSpacing.horizontalSpaceSmall
//                     : const SizedBox.shrink(),
//                 Expanded(
//                   child: CText(
//                     text,
//                     type: textType ?? TextType.titleMedium,
//                     fontWeight: fontWeight,
//                     color: textColor ?? AppColors.white,
//                   ),
//                 ),
//                 // AppSpacing.horizontalSpaceSmall,
//                 suffixIcon ?? const SizedBox.shrink(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../utils/ui_helpers/app_spacing.dart';
import '../text/custom_text.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? textColor;
  final double? borderWidth;
  final FontWeight? fontWeight;
  final Widget? btnIcon;
  final Widget? suffixIcon;
  final TextType? textType;
  final double? borderRadius;
  final BorderRadius? borderRadiusCust;
  final double? verticalPadding;
  final BorderRadius? customBorderRadius;
  final MainAxisAlignment? textAlignment;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;

  const ReusableButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.backgroundGradient,
    this.textStyle,
    this.borderColor,
    this.textColor,
    this.borderWidth,
    this.btnIcon,
    this.textType,
    this.fontWeight,
    this.suffixIcon,
    this.borderRadius,
    this.borderRadiusCust,
    this.customBorderRadius,
    this.textAlignment,
    this.verticalPadding,
    this.isLoading = false,
    this.width,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: customBorderRadius ?? BorderRadius.circular(borderRadius ?? 8.0),
        child: Container(
          width: width,
          padding: contentPadding ?? EdgeInsets.symmetric(
            vertical: verticalPadding ?? 8.0,
            horizontal: 8.0,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.mainColor,
            gradient: backgroundGradient,
              borderRadius:
          borderRadiusCust ?? BorderRadius.circular(borderRadius ?? 8.0),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0.0,
          ),
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: textColor ?? AppColors.white,
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: textAlignment == null ? 16.0 : 0.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: textAlignment ?? MainAxisAlignment.center,
                children: [
                  if (btnIcon != null) ...[
                    btnIcon!,
                    AppSpacing.horizontalSpaceSmall,
                  ],
                  Flexible(
                    child: CText(
                      text,
                      type: textType ?? TextType.titleMedium,
                      fontWeight: fontWeight,
                      color: textColor ?? AppColors.white,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    AppSpacing.horizontalSpaceSmall,
                    suffixIcon!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

