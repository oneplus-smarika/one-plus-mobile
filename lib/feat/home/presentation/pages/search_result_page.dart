import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneplus_app/core/core.dart';
import '../../data/model/bus_list_model.dart';
import '../widgets/bus_card_widget.dart';

class SearchResultsPage extends ConsumerStatefulWidget {
  final String fromCity;
  final String toCity;
  final String selectedDate;

  const SearchResultsPage({
    super.key,
    required this.fromCity,
    required this.toCity,
    required this.selectedDate,
  });

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        shadowColor: AppColors.gray400.withOpacity(0.3),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: CText(
          "Search Results",
          type: TextType.headlineSmall,
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Summary Header
            Container(
              width: double.infinity,
              color: AppColors.cardColor,
              padding: EdgeInsets.all(AppSpacing.pagePadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.gray400),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.busIcon,
                                height: 16,
                                width: 16,
                              ),
                              AppSpacing.horizontalSpaceSmall,
                              CText(
                                widget.fromCity,
                                type: TextType.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppSpacing.horizontalSpaceSmall,
                      SvgPicture.asset(AppAssets.backForthIcon, height: 20),
                      AppSpacing.horizontalSpaceSmall,
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.gray400),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.busIcon,
                                height: 16,
                                width: 16,
                              ),
                              AppSpacing.horizontalSpaceSmall,
                              CText(
                                widget.toCity,
                                type: TextType.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalSpaceSmall,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray400),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppColors.gray700,
                        ),
                        AppSpacing.horizontalSpaceSmall,
                        CText(
                          widget.selectedDate,
                          type: TextType.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
AppSpacing.verticalSpaceMedium,
            // Results Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppSpacing.pagePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CText(
                    "${busList.length} buses found for ${widget.fromCity} to ${widget.toCity}",
                    type: TextType.bodyLarge,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),

                ],
              ),
            ),

            busList.isEmpty
                ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_bus_outlined,
                      size: 64,
                      color: AppColors.gray400,
                    ),
                    AppSpacing.verticalSpaceMedium,
                    CText(
                      "No buses found",
                      type: TextType.titleMedium,
                      color: AppColors.gray600,
                    ),
                    AppSpacing.verticalSpaceSmall,
                    CText(
                      "Try searching for a different route or date",
                      type: TextType.bodyMedium,
                      color: AppColors.gray500,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: busList.length,
                itemBuilder: (context, index) {
                  final bus = busList[index];
                  return BusCard(
                    busName: bus.busName,
                    busType: bus.busType,
                    price: bus.price,
                    seatsLeft: bus.seatsLeft,
                    departure: bus.departure,
                    arrival: bus.arrival,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}