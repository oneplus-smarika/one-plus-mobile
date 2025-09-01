import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/ui_helpers/app_spacing.dart';
import '../../../../core/widgets/text/custom_text.dart';

class ReservationTerms extends StatelessWidget {
  const ReservationTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.orangeLight,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.security, color: AppColors.orange, size: 18),
                AppSpacing.horizontalSpaceSmall,
                CText(
                  "Reservation Terms:",
                  type: TextType.titleMedium,
                  fontWeight: FontWeight.w600,
                  color: AppColors.orange,
                ),
              ],
            ),
            AppSpacing.verticalSpaceSmall,

            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 8, right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Expanded(
                    child: CText(
                      "Pay at the bus counter before departure",
                      type: TextType.bodyMedium,
                      color: AppColors.gray800,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 8, right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Expanded(
                    child: CText(
                      "Reservation valid for 24 hours",
                      type: TextType.bodyMedium,
                      color: AppColors.gray800,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: CText(
                    "Booking fee: NPR 100",
                    type: TextType.bodyMedium,
                    color: AppColors.gray800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );;
  }
}
