import 'package:flutter/material.dart';
import 'package:oneplus_app/core/core.dart';
import 'package:oneplus_app/feat/home/presentation/pages/seat_selection_screen.dart';

class BusCard extends StatelessWidget {
  final String busName;
  final String busType;
  final String price;
  final String seatsLeft;
  final String departure;
  final String arrival;

  const BusCard({
    super.key,
    required this.busName,
    required this.busType,
    required this.price,
    required this.seatsLeft,
    required this.departure,
    required this.arrival,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SeatSelectionScreen(
                busName: busName,
                departureTime: departure,
                arrivalTime: arrival,
                price: price,
              );
            },
          ),
        );
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppAssets.onePlusLogo,
                          height: 38,
                          width: 38,
                        ),
                        AppSpacing.horizontalSpaceSmall,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: CText(
                                busName,
                                type: TextType.titleMedium,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CText(
                              busType,
                              type: TextType.bodySmall,
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CText(price, type: TextType.titleMedium),
                        CText(
                          seatsLeft,
                          type: TextType.bodySmall,
                          color: AppColors.gray900,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
                AppSpacing.verticalSpaceMedium,
                Row(
                  children: [
                    Chip(
                      backgroundColor: AppColors.cardColor,
                      side: BorderSide(color: AppColors.gray400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      label: CText(departure, type: TextType.bodySmall),
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 4,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    AppSpacing.horizontalSpaceSmall,
                    Chip(
                      backgroundColor: AppColors.cardColor,
                      side: BorderSide(color: AppColors.gray400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      label: CText(arrival, type: TextType.bodySmall),
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 4,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                AppSpacing.verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: CText(
                        "• LED TV • Comfortable Seats\n• Music System",
                        type: TextType.bodySmall,
                        color: AppColors.gray700,
                      ),
                    ),
                    Row(
                      spacing: 5,
                      children: [
                        CText("View Details", type: TextType.titleSmall),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.gray900,
                          size: 13,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
