import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/text/custom_text.dart';

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
      backgroundColor: isSelected ? AppColors.mainColor : AppColors.white,
      avatar:
          isSelected
              ? const Icon(
                Icons.calendar_month,
                color: AppColors.white,
                size: 30,
              )
              : null,
      label: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            CText(
              "$day ",
              color: isSelected ? AppColors.white : AppColors.gray700,
              type: TextType.bodyLarge,
            ),
            CText(
              month,
              color: isSelected ? AppColors.white : AppColors.gray700,
              type: TextType.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
