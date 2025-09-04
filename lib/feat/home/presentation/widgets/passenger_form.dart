import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneplus_app/core/core.dart';
import '../../../../core/widgets/forms/cust_dropdown.dart';
import '../controller/passenger_form_controller.dart';

class PassengerForm extends ConsumerWidget {
  final int passengerIndex;
  final String seatNumber;

  const PassengerForm({
    super.key,
    required this.passengerIndex,
    required this.seatNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(passengerFormProvider(seatNumber).notifier);

    ref.listen(passengerFormProvider(seatNumber), (previous, next) {
      controller.updateGender(next['gender']);
    });

    return Card(
      color: AppColors.cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.lightBlue[50],
                  child: Icon(Icons.person, color: AppColors.mainColor),
                ),
                AppSpacing.horizontalSpaceAverage,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      "Passenger $passengerIndex",
                      type: TextType.titleLarge,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                    AppSpacing.verticalSpaceSmall,
                    CText(
                      "Seat $seatNumber • NPR 2800",
                      type: TextType.bodyMedium,
                      color: AppColors.gray700,
                    ),
                    AppSpacing.verticalSpaceAverage,
                  ],
                ),
              ],
            ),
            AppSpacing.verticalSpaceMedium,

            /// Full Name
            CText("Full Name *", type: TextType.titleMedium),
            AppSpacing.verticalSpaceTiny,
            CustTextField(
              controller: controller.nameController,
              hintText: "Enter full name as per ID",
            ),
            AppSpacing.verticalSpaceMedium,

            /// Age + Gender Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText("Age *", type: TextType.titleMedium),
                      AppSpacing.verticalSpaceTiny,
                      CustTextField(
                        controller: controller.ageController,
                        hintText: "Enter age",
                        keyboardType: TextInputType.number,
                        suffixIcon: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                int current =
                                    int.tryParse(
                                      controller.ageController.text,
                                    ) ??
                                    0;
                                controller.ageController.text =
                                    (current + 1).toString();
                              },
                              child: Icon(Icons.arrow_drop_up, size: 24),
                            ),
                            InkWell(
                              onTap: () {
                                int current =
                                    int.tryParse(
                                      controller.ageController.text,
                                    ) ??
                                    0;
                                if (current > 0) {
                                  controller.ageController.text =
                                      (current - 1).toString();
                                }
                              },
                              child: const Icon(
                                Icons.arrow_drop_down,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    children: [
                      CText("Gender *", type: TextType.titleMedium),
                      AppSpacing.verticalSpaceTiny,
                      CustDropDown<String>(
                        labelText: "Gender *",
                        hintText: "Select",
                        borderColor: AppColors.gray400,
                        value: controller.gender,
                        items:
                            ["Male", "Female", "Other"]
                                .map(
                                  (g) => DropdownMenuItem<String>(
                                    value: g,
                                    child: CText(g),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          controller.updateGender(value);
                        },
                        borderRadius: 12,
                        marginVertical: 4,
                        marginHorizontal: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            AppSpacing.verticalSpaceMedium,

            /// Contact Number
            CText("Contact Number *", type: TextType.titleMedium),
            AppSpacing.verticalSpaceTiny,
            CustTextField(
              controller: controller.contactController,
              hintText: "+977 98XXXXXXXX",
              keyboardType: TextInputType.phone,
            ),
            AppSpacing.verticalSpaceMedium,
            CText("Emergency Contact (Optional)", type: TextType.titleMedium),
            AppSpacing.verticalSpaceTiny,
            CustTextField(
              controller: controller.emergencyContactController,
              hintText: "+977 98XXXXXXXX",
              keyboardType: TextInputType.phone,
            ),

            AppSpacing.verticalSpaceMedium,
          ],
        ),
      ),
    );
  }
}
