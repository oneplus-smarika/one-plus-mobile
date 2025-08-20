import 'package:flutter/material.dart';
import 'package:oneplus_app/core/core.dart';

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
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                      backgroundImage: AssetImage(AppAssets.appLogo),
                    ),
                    AppSpacing.horizontalSpaceSmall,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          busName,
                          type: TextType.bodyLarge,
                          fontWeight: FontWeight.bold,
                        ),
                        CText(
                          busType,
                          type: TextType.bodySmall,
                          color: AppColors.gray700,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CText(
                      price,
                      type: TextType.bodyLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    CText(
                      seatsLeft,
                      type: TextType.bodySmall,
                      color: AppColors.success,
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.verticalSpaceMedium,

            /// Timing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  backgroundColor: AppColors.white,

                  label: CText(departure, type: TextType.bodySmall),
                ),
                Chip(
                  backgroundColor: AppColors.white,
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const CText(
                    "View Details",
                    type: TextType.bodySmall,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
