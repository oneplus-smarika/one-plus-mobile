import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_assets.dart';
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
    {"day": "12", "month": "Aug", "isSelected": true},
    {"day": "13", "month": "Aug", "isSelected": false},
    {"day": "14", "month": "Aug", "isSelected": false},
    {"day": "15", "month": "Aug", "isSelected": false},
    {"day": "16", "month": "Aug", "isSelected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 260,
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
                AppSpacing.horizontalSpaceSmall,
                ReusableButton(
                  height: 60,
                  width: 110,
                  text: "Sep",
                  btnIcon: Icon(Icons.calendar_month, color: AppColors.white),
                  onPressed: () {},
                ),
              ],
            ),
            AppSpacing.verticalSpaceMedium,
            ReusableButton(
              btnIcon: const Icon(Icons.search, color: AppColors.white),
              text: "Search Buses",
              onPressed: () {},
            ),
          ],
        ),
        AppSpacing.verticalSpaceLarge,
        AppSpacing.verticalSpaceSmall,

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
                    "Available Routes for Today",
                    type: TextType.titleLarge,
                    color: AppColors.gray900,
                    fontWeight: FontWeight.w400,
                  ),
                  CText(
                    "20th Sep",
                    type: TextType.titleMedium,
                    color: AppColors.gray700,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              AppSpacing.horizontalSpaceSmall,
              Chip(
                label: Row(
                  children: [
                    SvgPicture.asset(AppAssets.resetLogo, height: 16),
                    AppSpacing.horizontalSpaceSmall,
                    CText(
                      "Reset",
                      type: TextType.bodyMedium,
                      color: AppColors.gray700,
                    ),
                  ],
                ),
                backgroundColor: AppColors.cardColor,
                side: const BorderSide(color: AppColors.gray300),
              ),
            ],
          ),
        ),
        AppSpacing.verticalSpaceSmall,
      ],
    );
  }
}
