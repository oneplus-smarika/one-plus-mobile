import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneplus_app/core/core.dart';
import '../controller/payment_controller.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final List<String> selectedSeats;
  final List<Map<String, dynamic>> passengerDetails;
  final String route;
  final String departureTime;
  final String arrivalTime;
  final String date;

  const PaymentPage({
    super.key,
    required this.selectedSeats,
    required this.passengerDetails,
    required this.route,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
  });

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  TextEditingController eSewaNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentProvider);
    final paymentController = ref.read(paymentProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CText(
              "Payment",
              type: TextType.headlineSmall,
              textAlign: TextAlign.left,
            ),
            const CText(
              "Choose your payment method",
              type: TextType.bodyMedium,
              color: AppColors.gray700,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: AppColors.gray300),
            AppSpacing.verticalSpaceSmall,

            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.directions_bus,
                    color: AppColors.white,
                    size: 24,
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CText(
                        "One Plus Yatayat",
                        type: TextType.titleLarge,
                        fontWeight: FontWeight.w600,
                      ),
                      const CText(
                        "Sleeper Bus",
                        type: TextType.bodyMedium,
                        color: AppColors.gray700,
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: CText(
                    widget.date,
                    type: TextType.bodySmall,
                    color: AppColors.gray700,
                  ),
                  backgroundColor: AppColors.white,
                  side: const BorderSide(color: AppColors.gray300),
                ),
              ],
            ),
            AppSpacing.verticalSpaceMedium,

            // Route Info
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.gray700,
                  size: 20,
                ),
                AppSpacing.horizontalSpaceTiny,
                CText(
                  widget.route,
                  type: TextType.titleMedium,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            AppSpacing.verticalSpaceSmall,

            Row(
              children: [
                CText(
                  widget.departureTime,
                  type: TextType.bodyLarge,
                  color: AppColors.gray700,
                ),
                AppSpacing.horizontalSpaceSmall,
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.gray700,
                  size: 16,
                ),
                AppSpacing.horizontalSpaceSmall,
                CText(
                  widget.arrivalTime,
                  type: TextType.bodyLarge,
                  color: AppColors.gray700,
                ),
              ],
            ),
            AppSpacing.verticalSpaceSmall,

            Row(
              children: [
                const CText(
                  "Seats:",
                  type: TextType.bodyMedium,
                  color: AppColors.gray700,
                ),
                AppSpacing.horizontalSpaceSmall,
                ...widget.selectedSeats.map(
                  (seat) => Chip(
                    label: CText(
                      seat,
                      type: TextType.bodySmall,
                      color: AppColors.gray700,
                    ),
                    backgroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.gray300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                  ),
                ),
              ],
            ),

            Divider(color: AppColors.gray300),
            AppSpacing.verticalSpaceMedium,

            const CText(
              "Passengers",
              type: TextType.titleLarge,
              fontWeight: FontWeight.w600,
            ),
            AppSpacing.verticalSpaceMedium,

            ...widget.passengerDetails.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> passenger = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      "${passenger['name']} (${passenger['age']}y, ${passenger['gender']})",
                      type: TextType.bodyLarge,
                    ),
                    CText(
                      "Seat ${widget.selectedSeats[index]}",
                      type: TextType.bodyMedium,
                      color: AppColors.gray700,
                    ),
                  ],
                ),
              );
            }),

            AppSpacing.verticalSpaceLarge,

            // Payment Methods Section
            const CText(
              "Select Payment Method",
              type: TextType.titleLarge,
              fontWeight: FontWeight.w600,
            ),
            AppSpacing.verticalSpaceMedium,

            paymentController.buildESewaOption(
              paymentState,
              eSewaNumberController,
            ),

            paymentController.buildQRCodeOption(paymentState),

            paymentController.buildReservationOption(paymentState),

            AppSpacing.verticalSpaceLarge,

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CText(
                    "Price Breakdown",
                    type: TextType.titleLarge,
                    fontWeight: FontWeight.w600,
                  ),
                  AppSpacing.verticalSpaceLarge,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Ticket Price (${widget.selectedSeats.length} seats)",
                        type: TextType.bodyLarge,
                      ),
                      CText(
                        "NPR ${(widget.selectedSeats.length * 2800).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
                        type: TextType.bodyLarge,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),

                  if (paymentState.selectedPaymentMethod ==
                      PaymentMethod.reserveOnly) ...[
                    AppSpacing.verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CText("Booking Fee", type: TextType.bodyLarge),
                        CText(
                          "NPR 100",
                          type: TextType.bodyLarge,
                          fontWeight: FontWeight.w500,
                          color: AppColors.orange,
                        ),
                      ],
                    ),
                  ],

                  AppSpacing.verticalSpaceMedium,
                  const Divider(color: AppColors.gray300),
                  AppSpacing.verticalSpaceSmall,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CText(
                        "Total Amount",
                        type: TextType.titleMedium,
                        fontWeight: FontWeight.w600,
                      ),
                      CText(
                        paymentState.selectedPaymentMethod ==
                                PaymentMethod.reserveOnly
                            ? "NPR 100" // Only booking fee for reservation
                            : "NPR ${(widget.selectedSeats.length * 2800).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
                        type: TextType.titleMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            AppSpacing.verticalSpaceLarge,

            Divider(color: AppColors.gray300),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                child: ReusableButton(
                  text:
                      paymentState.selectedPaymentMethod ==
                              PaymentMethod.reserveOnly
                          ? "Reserve Now - NPR 100"
                          : "Pay Now - NPR ${(widget.selectedSeats.length * 2800).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
                  width: double.infinity,
                  onPressed:
                      paymentState.selectedPaymentMethod != null &&
                              !paymentState.isProcessing
                          ? () => paymentController.processPayment(
                            context,
                            widget.selectedSeats,
                            widget.passengerDetails,
                            eSewaNumberController,
                            widget.route,
                            widget.departureTime,
                            widget.arrivalTime,
                            widget.date,
                          )
                          : null,
                  backgroundColor:
                      paymentState.selectedPaymentMethod != null
                          ? AppColors.mainColor
                          : AppColors.gray300,
                ),
              ),
            ),
            AppSpacing.verticalSpaceVeryLarge,
          ],
        ),
      ),
    );
  }
}
