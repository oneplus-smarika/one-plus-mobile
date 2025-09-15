import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CustDropDown<T> extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool isEnabled;
  final Color labelColor;
  final double? labelFontSize;
  final double? fontSize;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final String? Function(T?)? validator;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final void Function(T?)? onChanged;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;
  final double? borderRadius;
  final double? marginVertical;
  final double? marginHorizontal;
  final Color hintColor;
  final double? hintFontSize;
  final bool isFLoatingLabel;
  final Widget? headerWidget;
  final Color? backgroundColor;
  final Color? dropdownColor;
  final String Function(T?)? displayBuilder; // Add displayBuilder

  const CustDropDown({
    super.key,
    this.labelText,
    this.hintText,
    this.isEnabled = true,
    this.labelColor = AppColors.textColor1,
    this.labelFontSize,
    this.fontSize,
    this.prefixIcon,
    this.prefixIconColor,
    this.validator,
    this.items,
    this.value,
    this.onChanged,
    this.margin,
    this.borderColor,
    this.borderRadius,
    this.marginVertical,
    this.marginHorizontal,
    this.hintColor = AppColors.hintTextColor,
    this.hintFontSize,
    this.isFLoatingLabel = false,
    this.headerWidget,
    this.backgroundColor,
    this.dropdownColor,
    this.displayBuilder,
  });

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
          ButtonTheme(
            alignedDropdown: true, // This reduces the dropdown padding
            child: DropdownButtonFormField<T>(
              initialValue: value,

              // Customize the display of the selected item
              selectedItemBuilder:
                  displayBuilder != null
                      ? (context) =>
                          items!.map((item) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                displayBuilder!(item.value),
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList()
                      : null,

              items:
                  items?.map((item) {
                    return DropdownMenuItem<T>(
                      value: item.value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        // Adjust menu item padding
                        child: item.child,
                      ),
                    );
                  }).toList(),
              onChanged: isEnabled ? onChanged : null,
              validator: validator,
              menuMaxHeight: 300,
              // Maximum height of the dropdown menu
              icon: const Icon(Icons.keyboard_arrow_down, weight: 10),
              iconSize: 12,
              elevation: 2,
              style: TextStyle(
                color: AppColors.textColor1,
                fontSize: fontSize ?? 16.0,
              ),
              dropdownColor: dropdownColor ?? Colors.white,
              decoration: InputDecoration(
                isCollapsed: true,
                // This helps remove the default padding
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical:
                      16, // Adjust this value to center the text vertically
                ),
                hintText: hintText,
                enabled: isEnabled,
                isDense: true,
                // This helps with overall field density
                hintStyle: TextStyle(
                  color: hintColor,
                  fontSize: hintFontSize ?? 13,
                ),
                labelText: labelText,
                labelStyle: TextStyle(
                  color: AppColors.textColor3,
                  fontSize: labelFontSize ?? 13,
                ),
                // filled: true,
                fillColor: backgroundColor ?? AppColors.gray100,
                floatingLabelBehavior:
                    isFLoatingLabel
                        ? FloatingLabelBehavior.always
                        : FloatingLabelBehavior.never,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: borderColor ?? AppColors.gray200,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: borderColor ?? AppColors.gray200,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: borderColor ?? AppColors.gray200,
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
                    color: borderColor ?? AppColors.gray200,
                  ),
                ),
                prefixIcon:
                    prefixIcon != null
                        ? SizedBox.square(dimension: 18, child: prefixIcon)
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
