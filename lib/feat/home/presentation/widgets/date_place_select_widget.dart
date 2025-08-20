import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/ui_helpers/app_spacing.dart';
import '../../../../core/widgets/buttons/reusable_buttons.dart';
import '../../../../core/widgets/text/custom_text.dart';
import 'date_chip_widget.dart';

class DatePlaceSelectWidget extends StatefulWidget {
  const DatePlaceSelectWidget({super.key});

  @override
  State<DatePlaceSelectWidget> createState() => _DatePlaceSelectWidgetState();
}

class _DatePlaceSelectWidgetState extends State<DatePlaceSelectWidget> {
  final List<Map<String, dynamic>> dateList = [
    {"day": "12", "month": "Aug", "isSelected": false},
    {"day": "13", "month": "Aug", "isSelected": false},
    {"day": "14", "month": "Aug", "isSelected": false},
    {"day": "07", "month": "June", "isSelected": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dateList.length,
                  itemBuilder: (context, index) {
                    final date = dateList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: DateChipWidget(
                        day: date["day"],
                        month: date["month"],
                        isSelected: date["isSelected"],
                      ),
                    );
                  },
                ),
              ),
              AppSpacing.verticalSpaceMedium,
              ReusableButton(
                btnIcon: const Icon(Icons.search, color: AppColors.white),
                text: "Search Buses",
                onPressed: () {},
              ),
            ],
          ),
        ),
        AppSpacing.verticalSpaceVeryLarge,

        /// Title Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    "Kathmandu to Biratnagar",
                    type: TextType.titleLarge,
                    color: AppColors.gray900,
                    fontWeight: FontWeight.bold,
                  ),
                  CText(
                    "20th June",
                    type: TextType.bodyLarge,
                    color: AppColors.gray900,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.gray700),
                ),
                child: CText(
                  "Reset",
                  type: TextType.bodyMedium,
                  color: AppColors.mainColor,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.verticalSpaceAverage,
      ],
    );
  }
}
