import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../text/custom_text.dart';


class CustTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? suffixText;
  final bool showCursor;
  final bool isPassword;
  final Widget? prefixIcon;
  final double? labelFontSize;
  final double? fontSize;
  final Widget? suffixIcon;
  final bool isEnabled;
  final Color labelColor;
  final TextEditingController controller;
  final Function()? onSuffixIconClick;
  final Function()? onPrefixIconClick;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onFieldChanged;
  final TextInputType? keyboardType;
  final bool showBorder;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final EdgeInsetsGeometry? margin;
  final Color? textColor;
  final Color? borderColor;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final double? borderRadius;
  final bool readOnly;
  final double? marginVertical;
  final double? marginHorizontal;
  final Color hintColor;
  final double? hintFontSize;
  final bool isFLoatingLabel;
  final bool giveHeight;
  final void Function()? onEditingComplete;
  final bool obscureText;
  final Widget? headerWidget;
  final double? txtFieldHeight;
  final Widget? trailingWidget;
  final Color? backgroundColor;
  final String? errorText; // Added error text property

  const   CustTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.showCursor = true,
    this.isPassword = false,
    this.prefixIcon,
    this.labelFontSize,
    this.fontSize,
    this.suffixIcon,
    this.isEnabled = true,
    this.labelColor = AppColors.textColor1,
    required this.controller,
    this.onSuffixIconClick,
    this.onPrefixIconClick,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.onFieldChanged,
    this.keyboardType,
    this.showBorder = true,
    this.prefixIconColor,
    this.suffixIconColor,
    this.margin,
    this.maxLength,
    this.textColor,
    this.borderColor,
    this.maxLines,
    this.minLines,
    this.borderRadius,
    this.readOnly = false,
    this.marginVertical,
    this.marginHorizontal,
    this.hintColor = AppColors.hintTextColor,
    this.hintFontSize,
    this.isFLoatingLabel = false,
    this.giveHeight = true,
    this.onEditingComplete,
    this.obscureText = false,
    this.headerWidget,
    this.txtFieldHeight,
    this.trailingWidget,
    this.suffixText,
    this.backgroundColor,
    this.errorText, // Added to constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: marginHorizontal ?? 0,
        vertical: marginVertical ?? 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget ?? const SizedBox.shrink(),
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: maxLength,
                    obscureText: obscureText,
                    onEditingComplete: onEditingComplete,
                    focusNode: focusNode,
                    onFieldSubmitted: onFieldSubmitted,
                    onChanged: onFieldChanged,
                    validator: validator,
                    keyboardType: keyboardType,
                    controller: controller,
                    enabled: isEnabled,
                    style: TextStyle(
                      color: textColor ?? AppColors.textColor1,
                      fontSize: fontSize ?? 16.0,
                    ),
                    showCursor: showCursor,
                    readOnly: readOnly,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 12.0,
                      ),
                      hintText: hintText,
                      enabled: true,
                      isDense: false,
                      hintStyle: TextStyle(
                        color: hintColor,
                        fontSize: hintFontSize ?? 14,
                      ),
                      labelText: labelText,
                      labelStyle: TextStyle(
                        color: AppColors.textColor3,
                        fontSize: labelFontSize ?? 13,
                      ),
                      filled: true,
                      fillColor: backgroundColor ?? AppColors.gray100,
                      floatingLabelBehavior: isFLoatingLabel
                          ? FloatingLabelBehavior.always
                          : FloatingLabelBehavior.never,
                       errorText: errorText, // Added error text to decoration
                      errorStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                      errorMaxLines: 10,

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 12),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.red, // Changed error border color to red
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 12),
                        borderSide: const BorderSide(
                          width: 1.0,
                          color: Colors.red, // Changed focused error border color
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: borderColor ?? AppColors.gray400,
                        ),
                      ),
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: borderColor ?? AppColors.gray400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: borderColor ?? AppColors.mainColor,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: borderColor ?? AppColors.gray400,
                        ),
                      ),
                      prefixIcon: prefixIcon != null
                          ? SizedBox.square(
                        dimension: 18,
                        child: InkWell(
                          onTap: onPrefixIconClick,
                          child: prefixIcon,
                        ),
                      )
                          : null,
                      suffixIcon: suffixIcon != null
                          ? SizedBox.square(
                        dimension: 18,
                        child: InkWell(
                          onTap: onSuffixIconClick,
                          child: suffixIcon,
                        ),
                      )
                          : null,
                    ),
                    maxLines: maxLines ?? 1,
                  ),
                ),
                suffixText != null
                    ? Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: CText(
                      suffixText ?? '',
                      color: hintColor,
                      fontSize: hintFontSize ?? 18,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}