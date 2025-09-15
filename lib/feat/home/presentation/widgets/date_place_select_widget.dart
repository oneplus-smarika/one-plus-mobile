import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oneplus_app/core/core.dart';
import '../pages/search_result_page.dart';
import 'date_chip_widget.dart';

class DatePlaceSelectWidget extends StatefulWidget {
  final String? fromCity;
  final String? toCity;
  final Function(String) onDateSelected;

  const DatePlaceSelectWidget({
    super.key,
    required this.fromCity,
    required this.toCity,
    required this.onDateSelected,
  });

  @override
  State<DatePlaceSelectWidget> createState() => _DatePlaceSelectWidgetState();
}

class _DatePlaceSelectWidgetState extends State<DatePlaceSelectWidget> {
  List<Map<String, dynamic>> dateList = [];
  int selectedDateIndex = -1;
  DateTime? selectedDateFromPicker;

  @override
  void initState() {
    super.initState();
    _generateDateList();
  }

  void _generateDateList() {
    dateList.clear();
    DateTime now = DateTime.now();

    for (int i = 0; i < 5; i++) {
      DateTime date = now.add(Duration(days: i));
      String day = date.day.toString();
      String month = _getMonthAbbreviation(date.month);

      dateList.add({
        "day": day,
        "month": month,
        "isSelected": false,
        "fullDate": date,
      });
    }
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }

  void selectDate(int index) {
    setState(() {
      // Reset all selections
      for (int i = 0; i < dateList.length; i++) {
        dateList[i]["isSelected"] = false;
      }
      selectedDateFromPicker = null; // Clear picker selection

      // Select new date
      dateList[index]["isSelected"] = true;
      selectedDateIndex = index;

      // Notify parent with formatted date
      final selectedDate = dateList[index]["fullDate"] as DateTime;
      String formattedDate =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      widget.onDateSelected(formattedDate);
    });
  }

  String getSelectedDateString() {
    if (selectedDateFromPicker != null) {
      String day = selectedDateFromPicker!.day.toString();
      String month = _getMonthAbbreviation(selectedDateFromPicker!.month);
      return "$day $month";
    }

    if (selectedDateIndex == -1) {
      return "No date selected";
    }

    final selectedDate = dateList[selectedDateIndex];
    return "${selectedDate["day"]} ${selectedDate["month"]}";
  }

  String getFormattedSelectedDate() {
    if (selectedDateFromPicker != null) {
      return "${selectedDateFromPicker!.day}/${selectedDateFromPicker!.month}/${selectedDateFromPicker!.year}";
    }

    if (selectedDateIndex != -1) {
      final selectedDate = dateList[selectedDateIndex]["fullDate"] as DateTime;
      return "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    }

    return "Select Date";
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
                AppSpacing.horizontalSpaceMedium,
                Expanded(
                  child: ReusableButton(
                    height: 60,
                    width: 110,
                    text:
                        selectedDateFromPicker != null
                            ? "${selectedDateFromPicker!.day}/${selectedDateFromPicker!.month}"
                            : "Date",
                    btnIcon: Icon(Icons.calendar_month, color: AppColors.white),
                    onPressed: () {
                      _showDatePicker();
                    },
                  ),
                ),
              ],
            ),
            AppSpacing.verticalSpaceLarge,

            ReusableButton(
              btnIcon: const Icon(Icons.search, color: AppColors.white),
              text: "Search Buses",
              onPressed: _onSearchPressed,
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
                      (selectedDateIndex == -1 &&
                              selectedDateFromPicker == null)
                          ? "Available Routes for Today"
                          : "Available Routes for ${getSelectedDateString()}",
                      type: TextType.titleMedium,
                      color: AppColors.gray900,
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
                    selectedDateFromPicker = null;

                    widget.onDateSelected("Select Date");
                  });
                },
                child: Chip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
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

        String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
        widget.onDateSelected(formattedDate);
      });
    }
  }

  void _onSearchPressed() {
    if (widget.fromCity == null || widget.fromCity!.isEmpty) {
      _showSnackBar("Please select departure city");
      return;
    }

    if (widget.toCity == null || widget.toCity!.isEmpty) {
      _showSnackBar("Please select destination city");
      return;
    }

    if (widget.fromCity == widget.toCity) {
      _showSnackBar("Departure and destination cities cannot be the same");
      return;
    }

    String selectedDate = getFormattedSelectedDate();
    if (selectedDate == "Select Date") {
      _showSnackBar("Please select travel date");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SearchResultsPage(
              fromCity: widget.fromCity!,
              toCity: widget.toCity!,
              selectedDate: selectedDate,
            ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      AppMethods.showCustomSnackBar(context: context, message: message),
    );
  }
}
