import 'package:flutter/material.dart';
import 'package:oneplus_app/core/extension/app_typography.dart';


/// Defines the style of text to be used, expanded to include all relevant Material 3 text styles.
enum TextType {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

class CText extends StatelessWidget {
  final String text;
  final TextType type;
  final TextAlign textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? lineHeight;
  final TextDecoration? decoration; // Underline feature added

  const CText(
      this.text, {
        Key? key,
        this.type = TextType.bodyMedium,
        this.textAlign = TextAlign.start,
        this.color,
        this.maxLines,
        this.fontWeight,
        this.overflow,
        this.fontSize,
        this.lineHeight,
        this.decoration, // Allow underline feature
      }) : super(key: key);

  TextStyle _getStyle(BuildContext context) {
    TextStyle baseStyle;

    switch (type) {
      case TextType.displayLarge:
        baseStyle = context.displayLarge;
        break;
      case TextType.displayMedium:
        baseStyle = context.displayMedium;
        break;
      case TextType.displaySmall:
        baseStyle = context.displaySmall;
        break;
      case TextType.headlineLarge:
        baseStyle = context.headlineLarge;
        break;
      case TextType.headlineMedium:
        baseStyle = context.headlineMedium;
        break;
      case TextType.headlineSmall:
        baseStyle = context.headlineSmall;
        break;
      case TextType.titleLarge:
        baseStyle = context.titleLarge;
        break;
      case TextType.titleMedium:
        baseStyle = context.titleMedium;
        break;
      case TextType.titleSmall:
        baseStyle = context.titleSmall;
        break;
      case TextType.bodyLarge:
        baseStyle = context.bodyLarge;
        break;
      case TextType.bodyMedium:
        baseStyle = context.bodyMedium;
        break;
      case TextType.bodySmall:
        baseStyle = context.bodySmall;
        break;
      case TextType.labelLarge:
        baseStyle = context.labelLarge;
        break;
      case TextType.labelMedium:
        baseStyle = context.labelMedium;
        break;
      case TextType.labelSmall:
        baseStyle = context.labelSmall;
        break;
      }

    return baseStyle.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: lineHeight,
      decoration: decoration ?? TextDecoration.none, // Apply underline if passed
      fontFamily: baseStyle.fontFamily,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: _getStyle(context),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
