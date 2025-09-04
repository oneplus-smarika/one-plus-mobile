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
    Key? key,
    required this.busName,
    required this.busType,
    required this.price,
    required this.seatsLeft,
    required this.departure,
    required this.arrival,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return  SeatSelectionScreen(busName:busName,
                departureTime: departure,
                arrivalTime: arrival,
                price: price,
              );
            },
          ),
        );
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Chip(
          backgroundColor: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Bus Title & Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: AppColors.cardColor,
                          backgroundImage: AssetImage(AppAssets.appLogo),
                        ),
                        AppSpacing.horizontalSpaceSmall,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: CText(
                                busName,
                                type: TextType.titleLarge,
                                fontWeight: FontWeight.w300,
                                color: AppColors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CText(
                              busType,
                              type: TextType.bodyMedium,
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w300,
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

                /// Timing
                Row(
                  children: [
                    Chip(
                      backgroundColor: AppColors.cardColor,
                      side: BorderSide(color: AppColors.mainColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      label: CText(departure, type: TextType.bodySmall),
                    ),
                    AppSpacing.horizontalSpaceAverage,
                    Chip(
                      backgroundColor: AppColors.cardColor,
                      side: BorderSide(color: AppColors.mainColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      label: CText(arrival, type: TextType.bodySmall),
                    ),
                  ],
                ),
                AppSpacing.verticalSpaceSmall,

                /// Features & Button
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
