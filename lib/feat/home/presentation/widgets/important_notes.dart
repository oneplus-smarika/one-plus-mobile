import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/ui_helpers/app_spacing.dart';
import '../../../../core/widgets/text/custom_text.dart';

class ImportantNotes extends StatelessWidget {
  const ImportantNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.05),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(
          color: AppColors.mainColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CText(
            "Important Notes",
            type: TextType.titleLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
          AppSpacing.verticalSpaceLarge,
          _buildInstructionItem(
            "Please carry a valid ID proof during travel",
          ),
          _buildInstructionItem(
            "Names should match exactly with your ID documents",
          ),
          _buildInstructionItem(
            "Contact number will be used for booking confirmations",
          ),
          _buildInstructionItem(
            "Emergency contact is recommended for safety purposes",
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String text, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 8, right: 12),
            decoration: const BoxDecoration(
              color: AppColors.mainColor, // Darker blue for text
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: CText(
              text,
              type: TextType.bodyMedium,
              color: AppColors.mainColor, // Darker blue for text
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}