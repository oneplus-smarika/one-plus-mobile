import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/ui_helpers/app_spacing.dart';
import '../../../../core/widgets/buttons/reusable_buttons.dart';
import '../../../../core/widgets/text/custom_text.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText("20% OFF", type: TextType.titleLarge, color: AppColors.white),
          AppSpacing.verticalSpaceTiny,
          CText(
            "SAVEMORE",
            type: TextType.headlineSmall,
            color: AppColors.white,
          ),
          AppSpacing.verticalSpaceTiny,
          CText(
            "SINGAPORE MALAYSIA",
            type: TextType.bodyMedium,
            color: AppColors.white,
          ),
          AppSpacing.verticalSpaceSmall,
          ReusableButton(
            width: 180,
            backgroundColor: AppColors.flag,
            text: "Use Code: #07704",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
