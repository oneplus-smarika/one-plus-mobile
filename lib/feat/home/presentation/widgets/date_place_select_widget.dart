import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oneplus_app/core/core.dart';
import 'date_chip_widget.dart';

class DatePlaceSelectWidget extends StatefulWidget {
  const DatePlaceSelectWidget({super.key});

  @override
  State<DatePlaceSelectWidget> createState() => _DatePlaceSelectWidgetState();
}

class _DatePlaceSelectWidgetState extends State<DatePlaceSelectWidget> {
  List<Map<String, dynamic>> dateList = [
    {"day": "12", "month": "Aug", "isSelected": false},
    {"day": "13", "month": "Aug", "isSelected": false},
    {"day": "14", "month": "Aug", "isSelected": false},
    {"day": "15", "month": "Aug", "isSelected": false},
    {"day": "16", "month": "Aug", "isSelected": false},
  ];

  int selectedDateIndex = -1;
  DateTime? selectedDateFromPicker;

  void selectDate(int index) {
    setState(() {
      for (int i = 0; i < dateList.length; i++) {
        dateList[i]["isSelected"] = false;
      }
      dateList[index]["isSelected"] = true;
      selectedDateIndex = index;
    });
  }

  String getSelectedDateString() {
    if (selectedDateIndex == -1) {
      return "No date selected";
    }
    final selectedDate = dateList[selectedDateIndex];
    return "${selectedDate["day"]} ${selectedDate["month"]}";
  }

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
                        child: GestureDetector(
                          onTap: () => selectDate(index),
                          child: DateChipWidget(
                            day: date["day"],
                            month: date["month"],
                            isSelected: date["isSelected"],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                Expanded(
                  child: ReusableButton(
                    height: 60,
                    width: 110,
                    text: "Sep",
                    btnIcon: Icon(Icons.calendar_month, color: AppColors.white),
                    onPressed: () {
                      _showDatePicker();
                    },
                  ),
                ),
              ],
            ),
            AppSpacing.verticalSpaceMedium,
            ReusableButton(
              btnIcon: const Icon(Icons.search, color: AppColors.white),
              text: "Search Buses",
              onPressed: () {
                if (selectedDateIndex != -1) {
                } else {
                  AppMethods.showCustomSnackBar(
                    context: context,
                    message:
                        selectedDateFromPicker == null
                            ? "Please select a date"
                            : "Your selected date is: ${selectedDateFromPicker!.day}/${selectedDateFromPicker!.month}/${selectedDateFromPicker!.year}",
                  );
                }
              },
            ),
          ],
        ),
        AppSpacing.verticalSpaceLarge,

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      selectedDateIndex == -1
                          ? "Select a date to view available routes"
                          : "Available Routes for ${getSelectedDateString()}",
                      type: TextType.titleMedium,
                      color: AppColors.gray900,
                      fontWeight: FontWeight.w400,
                    ),
                    if (selectedDateIndex != -1)
                      CText(
                        getSelectedDateString(),
                        type: TextType.titleMedium,
                        color: AppColors.gray700,
                        fontWeight: FontWeight.w400,
                      ),
                  ],
                ),
              ),
              AppSpacing.horizontalSpaceSmall,
              GestureDetector(
                onTap: () {
                  setState(() {
                    for (int i = 0; i < dateList.length; i++) {
                      dateList[i]["isSelected"] = false;
                    }
                    selectedDateIndex = -1;
                  });
                },
                child: Chip(
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
              ),
            ],
          ),
        ),
        AppSpacing.verticalSpaceSmall,
      ],
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.mainColor,
              onPrimary: AppColors.white,
              onSurface: AppColors.gray700,
            ),
          ),
          child: child ?? const Text(''),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        for (int i = 0; i < dateList.length; i++) {
          dateList[i]["isSelected"] = false;
        }
        selectedDateIndex = -1;
        selectedDateFromPicker = picked;
      });
    }
  }
}
