import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneplus_app/core/core.dart';
import '../controller/passenger_details_controller.dart';
import '../widgets/passenger_form.dart';

class PassengerDetailsPage extends ConsumerStatefulWidget {
  final List<String> selectedSeats;

  const PassengerDetailsPage({super.key, required this.selectedSeats});

  @override
  ConsumerState<PassengerDetailsPage> createState() => _PassengerDetailsPageState();
}

class _PassengerDetailsPageState extends ConsumerState<PassengerDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Defer the initialization to after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(passengerDetailsProvider.notifier);
      controller.initControllers(widget.selectedSeats.length);
    });
  }

  @override
  void dispose() {
    final controller = ref.read(passengerDetailsProvider.notifier);
    controller.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllers = ref.watch(passengerDetailsProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(
              "Passenger Details",
              type: TextType.headlineSmall,
              textAlign: TextAlign.left,
            ),
            CText(
              "${widget.selectedSeats.length} Passengers",
              type: TextType.bodyMedium,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: AppColors.gray700),
              AppSpacing.horizontalSpaceTiny,
              CText(
                "Kathmandu to Biratnagar",
                type: TextType.titleLarge,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              const Spacer(),
              Chip(
                label: CText(
                  "20th Sep",
                  type: TextType.bodyMedium,
                  color: AppColors.gray700,
                ),
                backgroundColor: AppColors.cardColor,
                side: const BorderSide(color: AppColors.gray300),
              ),
            ],
          ),
          AppSpacing.verticalSpaceTiny,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CText(
                    "KTM 4:00 PM",
                    type: TextType.bodyLarge,
                    color: AppColors.gray700,
                  ),
                  AppSpacing.horizontalSpaceTiny,
                  const Icon(
                    Icons.arrow_forward_outlined,
                    color: AppColors.gray700,
                    size: 16,
                  ),
                  AppSpacing.horizontalSpaceTiny,
                  CText(
                    "BIR 5:00 AM",
                    type: TextType.bodyLarge,
                    color: AppColors.gray700,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              CText(
                "Selected Seats:",
                type: TextType.bodyLarge,
                color: AppColors.gray700,
              ),
              AppSpacing.horizontalSpaceSmall,
              Chip(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                label: CText(
                  "1C",
                  type: TextType.bodyMedium,
                  color: AppColors.gray700,
                ),
                backgroundColor: AppColors.cardColor,
                side: const BorderSide(color: AppColors.gray300),
              ),
            ],
          ),

          AppSpacing.verticalSpaceMedium,
          Divider(color: AppColors.gray300),

          /// Generate Passenger Forms
          ...List.generate(widget.selectedSeats.length, (index) {
            return PassengerForm(
              passengerIndex: index + 1,
              seatNumber: widget.selectedSeats[index],
            );
          }),

          AppSpacing.verticalSpaceLarge,

          /// Important Notes
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  "Important Notes",
                  color: Colors.blue[900],
                  type: TextType.titleLarge,
                  fontWeight: FontWeight.w600,
                ),
                AppSpacing.verticalSpaceSmall,
                CText(
                  "• Please carry a valid ID proof during travel",
                  type: TextType.bodyLarge,
                  color: Colors.blue[900],
                ),
                CText(
                  "• Names should match exactly with your ID documents",
                  type: TextType.bodyLarge,
                  color: Colors.blue[900],
                ),
                CText(
                  "• Contact number will be used for booking confirmations",
                  type: TextType.bodyLarge,
                  color: Colors.blue[900],
                ),
                CText(
                  "• Emergency contact is recommended for safety purposes",
                  type: TextType.bodyLarge,
                  color: Colors.blue[900],
                ),
              ],
            ),
          ),

          AppSpacing.verticalSpaceLarge,
        ],
      ),
      bottomNavigationBar:
      widget.selectedSeats.isNotEmpty
          ? SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CText(
                    "Total Amount",
                    type: TextType.titleMedium,
                    fontWeight: FontWeight.w600,
                  ),
                  CText(
                    "NPR ${widget.selectedSeats.length * 2800}",
                    type: TextType.titleLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              AppSpacing.verticalSpaceTiny,

              /// Seats summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CText(
                      "${widget.selectedSeats.length} seat(s)"
                          " • One Plus Yatayat",
                      type: TextType.bodyMedium,
                      color: AppColors.gray700,
                    ),
                  ),
                  const CText(
                    "Including all taxes",
                    type: TextType.bodyMedium,
                    color: AppColors.gray700,
                  ),
                ],
              ),

              AppSpacing.verticalSpaceMedium,

              /// Continue Button
              ReusableButton(
                text: "Continue to Payment",
                width: double.infinity,
                onPressed: () {
                  // TODO: Save details + Navigate to Payment
                },
              ),
            ],
          ),
        ),
      )
          : const SizedBox(),
    );
  }
}