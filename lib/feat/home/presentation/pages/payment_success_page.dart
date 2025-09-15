import 'package:flutter/material.dart';
import 'package:oneplus_app/feat/home/presentation/widgets/important_instruction.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/methods/app_methods.dart';
import '../../../../core/utils/ui_helpers/app_spacing.dart';
import '../../../../core/widgets/buttons/reusable_buttons.dart';
import '../../../../core/widgets/text/custom_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/payment_success_controller.dart';
import 'home_page.dart';

class PaymentSuccessPage extends ConsumerWidget {
  final String bookingId;
  final List<String> selectedSeats;
  final List<Map<String, dynamic>> passengerDetails;
  final String route;
  final String departureTime;
  final String arrivalTime;
  final String date;
  final String paymentMethod;
  final double amountPaid;
  final DateTime transactionDate;
  final DateTime? reservationExpiry;
  final double? totalAmount;

  const PaymentSuccessPage({
    super.key,
    required this.bookingId,
    required this.selectedSeats,
    required this.passengerDetails,
    required this.route,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
    required this.paymentMethod,
    required this.amountPaid,
    required this.transactionDate,
    this.reservationExpiry,
    this.totalAmount,
  });

  PaymentSuccessData get _paymentData => PaymentSuccessData(
    bookingId: bookingId,
    selectedSeats: selectedSeats,
    passengerDetails: passengerDetails,
    route: route,
    departureTime: departureTime,
    arrivalTime: arrivalTime,
    date: date,
    paymentMethod: paymentMethod,
    amountPaid: amountPaid,
    transactionDate: transactionDate,
    reservationExpiry: reservationExpiry,
    totalAmount: totalAmount,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(paymentSuccessControllerProvider(_paymentData).notifier);
    final state = ref.watch(paymentSuccessControllerProvider(_paymentData));
    final isReservation = controller.isReservation;

    ref.listen(paymentSuccessControllerProvider(_paymentData), (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
        controller.clearError();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(controller, isReservation),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacing.verticalSpaceMedium,

                    // Booking Confirmed/Reserved Card
                    _buildConfirmationCard(context, controller, isReservation),

                    // Payment Required Alert (Only for reservations)
                    if (isReservation) ...[
                      AppSpacing.verticalSpaceLarge,
                      _buildPaymentRequiredAlert(controller),
                    ],

                    AppSpacing.verticalSpaceLarge,

                    // Trip Details Card
                    _buildTripDetailsCard(controller),

                    AppSpacing.verticalSpaceLarge,

                    // Seat Information Card
                    _buildSeatInformationCard(controller, isReservation),

                    AppSpacing.verticalSpaceLarge,

                    // Passengers Card
                    _buildPassengersCard(),

                    AppSpacing.verticalSpaceLarge,

                    // Payment Details Card
                    _buildPaymentDetailsCard(controller, isReservation),

                    // Payment Instructions (Only for reservations)
                    if (isReservation) ...[
                      AppSpacing.verticalSpaceLarge,
                      _buildPaymentInstructions(),
                    ],

                    AppSpacing.verticalSpaceLarge,
                    if (!isReservation) ImportantInstruction(),
                    AppSpacing.verticalSpaceLarge,

                    // Action Buttons
                    _buildActionButtons(context, controller, isReservation, state.isLoading),

                    AppSpacing.verticalSpaceVeryLarge,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(PaymentSuccessController controller, bool isReservation) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: isReservation ? const Color(0xFFFF4500) : AppColors.success,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              isReservation ? Icons.access_time : Icons.check,
              color: isReservation ? const Color(0xFFFF4500) : AppColors.success,
              size: 40,
            ),
          ),
          AppSpacing.verticalSpaceMedium,
          CText(
            controller.headerTitle,
            type: TextType.headlineMedium,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          AppSpacing.verticalSpaceSmall,
          CText(
            controller.headerSubtitle,
            type: TextType.bodyLarge,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationCard(
      BuildContext context,
      PaymentSuccessController controller,
      bool isReservation,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isReservation
            ? const Color(0xFFFFF4E6)
            : AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isReservation
              ? const Color(0xFFFFB366)
              : AppColors.success.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          CText(
            controller.confirmationTitle,
            type: TextType.titleLarge,
            color: isReservation
                ? const Color(0xFFB8860B)
                : AppColors.success,
            fontWeight: FontWeight.bold,
          ),
          AppSpacing.verticalSpaceSmall,
          GestureDetector(
            onTap: () async {
              await controller.copyBookingId();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Booking ID copied to clipboard"),
                  backgroundColor: isReservation
                      ? const Color(0xFFFF4500)
                      : AppColors.success,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.gray300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CText(
                    bookingId,
                    type: TextType.titleMedium,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gray800,
                  ),
                  AppSpacing.horizontalSpaceSmall,
                  const Icon(Icons.copy, size: 16, color: AppColors.gray600),
                ],
              ),
            ),
          ),
          AppSpacing.verticalSpaceSmall,
          CText(
            isReservation ? "Reserved" : "Save this booking ID for future reference",
            type: TextType.bodyMedium,
            color: isReservation ? const Color(0xFFB8860B) : AppColors.success,
          ),
          if (isReservation && controller.reservationExpiryText.isNotEmpty) ...[
            AppSpacing.verticalSpaceSmall,
            CText(
              controller.reservationExpiryText,
              type: TextType.bodyMedium,
              color: const Color(0xFFB8860B),
              fontWeight: FontWeight.w500,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentRequiredAlert(PaymentSuccessController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFB3B3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber, color: Color(0xFFDC143C), size: 20),
              AppSpacing.horizontalSpaceSmall,
              const CText(
                "Payment Required",
                type: TextType.titleMedium,
                color: Color(0xFFDC143C),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          AppSpacing.verticalSpaceSmall,
          CText(
            controller.paymentRequiredText,
            type: TextType.bodyMedium,
            color: const Color(0xFFDC143C),
          ),
          AppSpacing.verticalSpaceSmall,
          const CText(
            "Reservation expires in 24 hours. Pay early to secure your seats!",
            type: TextType.bodyMedium,
            color: Color(0xFFDC143C),
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildTripDetailsCard(PaymentSuccessController controller) {
    final tripDetails = PaymentSuccessController.getTripDetails(_paymentData);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.mainColor, size: 20),
              AppSpacing.horizontalSpaceSmall,
              const CText(
                "Trip Details",
                type: TextType.titleLarge,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          AppSpacing.verticalSpaceLarge,
          ...tripDetails.map(
                (detail) => _buildDetailRow(detail['label']!, detail['value']!),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatInformationCard(PaymentSuccessController controller, bool isReservation) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CText(
            "Seat Information",
            type: TextType.titleLarge,
            fontWeight: FontWeight.bold,
          ),
          AppSpacing.verticalSpaceMedium,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedSeats
                .map(
                  (seat) => Chip(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                label: CText(
                  "Seat $seat",
                  type: TextType.bodyMedium,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w500,
                ),
                backgroundColor: AppColors.cardColor,
                side: const BorderSide(color: AppColors.gray300),
              ),
            )
                .toList(),
          ),
          AppSpacing.verticalSpaceSmall,
          CText(
            controller.seatStatusText,
            type: TextType.bodyMedium,
            color: AppColors.gray600,
          ),
        ],
      ),
    );
  }

  Widget _buildPassengersCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person, color: AppColors.mainColor, size: 20),
              AppSpacing.horizontalSpaceSmall,
              const CText(
                "Passengers",
                type: TextType.titleLarge,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          AppSpacing.verticalSpaceLarge,
          ...passengerDetails.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> passenger = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          passenger['name'] ?? '',
                          type: TextType.bodyLarge,
                          fontWeight: FontWeight.w600,
                        ),
                        AppSpacing.verticalSpaceTiny,
                        CText(
                          "Age: ${passenger['age']}   Gender: ${passenger['gender']}",
                          type: TextType.bodyMedium,
                          color: AppColors.gray600,
                        ),
                        if (passenger['phone'] != null) ...[
                          AppSpacing.verticalSpaceTiny,
                          Row(
                            children: [
                              const Icon(Icons.phone, size: 14, color: AppColors.gray600),
                              AppSpacing.horizontalSpaceTiny,
                              CText(
                                passenger['phone'],
                                type: TextType.bodySmall,
                                color: AppColors.gray600,
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.gray200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CText(
                      "Seat ${selectedSeats[index]}",
                      type: TextType.bodySmall,
                      color: AppColors.gray700,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailsCard(PaymentSuccessController controller, bool isReservation) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            isReservation ? "Payment Summary" : "Payment Details",
            type: TextType.titleLarge,
            fontWeight: FontWeight.bold,
          ),
          AppSpacing.verticalSpaceLarge,

          if (isReservation) ...[
            _buildDetailRow(
              "Booking Fee (Paid)",
              controller.formatCurrency(amountPaid),
              valueColor: AppColors.success,
            ),
            _buildDetailRow(
              "Remaining Amount",
              controller.formatCurrency(controller.remainingAmount),
              valueColor: const Color(0xFFFF4500),
            ),
            _buildDetailRow(
              "Total Ticket Price",
              controller.formatCurrency(totalAmount ?? 0),
              valueColor: AppColors.gray800,
            ),
          ] else ...[
            _buildDetailRow("Payment Method", controller.getPaymentMethodDisplay()),
            _buildDetailRow(
              "Amount Paid",
              controller.formatCurrency(amountPaid),
              valueColor: AppColors.success,
            ),
          ],

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CText(
                "Payment Status",
                type: TextType.bodyMedium,
                color: AppColors.gray600,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isReservation
                      ? const Color(0xFFFF4500).withOpacity(0.1)
                      : AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CText(
                  controller.paymentStatusText,
                  type: TextType.bodySmall,
                  color: isReservation ? const Color(0xFFFF4500) : AppColors.success,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          AppSpacing.verticalSpaceSmall,
          _buildDetailRow(
            "Transaction Date",
            controller.formatDateTime(transactionDate),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInstructions() {
    final instructions = PaymentSuccessController.getPaymentInstructions();

    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.05),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: AppColors.mainColor.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CText(
            "Payment Instructions",
            type: TextType.titleMedium,
            color: AppColors.mainColor,
            fontWeight: FontWeight.bold,
          ),
          AppSpacing.verticalSpaceMedium,
          ...instructions.map((instruction) => _buildInstructionItem(instruction)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context,
      PaymentSuccessController controller,
      bool isReservation,
      bool isLoading,
      ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableButton(
              text: isReservation ? "Share Booking Details" : "Download Ticket",
              width: isReservation ? 350 : 180,
              textColor: AppColors.gray800,
              btnIcon: Icon(
                isReservation ? Icons.share_outlined : Icons.download_outlined,
                color: AppColors.gray800,
              ),
              onPressed: isLoading ? null : () async {
                if (isReservation) {
                  await controller.shareBookingDetails();
                  AppMethods.showCustomSnackBar(
                    context: context,
                    message: "Booking details shared successfully",
                  );
                } else {
                  await controller.downloadTicket();
                  AppMethods.showCustomSnackBar(
                    context: context,
                    message: "Ticket download functionality coming soon!",
                  );
                }
              },
              backgroundColor: AppColors.white,
              borderColor: AppColors.gray800,
            ),
            if (!isReservation)
              ReusableButton(
                text: "Share Ticket",
                width: 150,
                textColor: AppColors.gray800,
                btnIcon: const Icon(Icons.share_outlined, color: AppColors.gray800),
                onPressed: isLoading ? null : () async {
                  await controller.shareTicket();
                  AppMethods.showCustomSnackBar(
                    context: context,
                    message: "Ticket shared successfully",
                  );
                },
                backgroundColor: AppColors.white,
                borderColor: AppColors.gray800,
              )
            else
              const SizedBox(),
          ],
        ),
        AppSpacing.verticalSpaceMedium,
        ReusableButton(
          text: "Back to Home",
          width: double.infinity,
          onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
          },
          btnIcon: const Icon(Icons.home_outlined, color: AppColors.white),
          backgroundColor: AppColors.mainColor,
          textColor: AppColors.white,
        ),
      ],
    );
  }


  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CText(
              label,
              type: TextType.bodyMedium,
              color: AppColors.gray600,
            ),
          ),
          Expanded(
            flex: 3,
            child: CText(
              value,
              type: TextType.bodyMedium,
              color: valueColor ?? AppColors.gray800,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: CText(
              instruction,
              type: TextType.bodyMedium,
              color: AppColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
