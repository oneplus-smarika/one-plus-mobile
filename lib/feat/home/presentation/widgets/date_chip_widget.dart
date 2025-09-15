import 'package:flutter/material.dart';
import 'package:oneplus_app/core/core.dart';

class DateChipWidget extends StatelessWidget {
  final String day;
  final String month;
  final bool isSelected;

  const DateChipWidget({
    super.key,
    required this.day,
    required this.month,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColors.white,
      side: BorderSide(
        color: isSelected ? AppColors.mainColor : AppColors.gray200,
        width: isSelected ? 2 : 1,
      ),
      label: Column(
        children: [
          CText("$day ", color: AppColors.gray700, type: TextType.bodyMedium),
          CText(month, color: AppColors.gray700, type: TextType.bodyMedium),
        ],
      ),
    );
  }
}
