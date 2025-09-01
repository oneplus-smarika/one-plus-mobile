import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneplus_app/feat/home/presentation/widgets/reservation_terms.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/ui_helpers/app_spacing.dart';
import '../../../../core/widgets/forms/cust_text_field.dart';
import '../../../../core/widgets/text/custom_text.dart';

enum PaymentMethod { esewa, qrCode, reserveOnly }

class PaymentState {
  final PaymentMethod? selectedPaymentMethod;
  final bool isProcessing;
  final String? error;

  PaymentState({
    this.selectedPaymentMethod,
    this.isProcessing = false,
    this.error,
  });

  PaymentState copyWith({
    PaymentMethod? selectedPaymentMethod,
    bool? isProcessing,
    String? error,
  }) {
    return PaymentState(
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error ?? this.error,
    );
  }
}

final paymentProvider = StateNotifierProvider<PaymentController, PaymentState>((
  ref,
) {
  return PaymentController();
});

class PaymentController extends StateNotifier<PaymentState> {
  PaymentController() : super(PaymentState());

  void selectPaymentMethod(PaymentMethod method) {
    state = state.copyWith(selectedPaymentMethod: method, error: null);
  }

  Future<void> processPayment(
    BuildContext context,
    List<String> selectedSeats,
    List<Map<String, dynamic>> passengerDetails,
    TextEditingController eSewaController,
  ) async {
    if (state.selectedPaymentMethod == null) return;

    state = state.copyWith(isProcessing: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 2));

      switch (state.selectedPaymentMethod!) {
        case PaymentMethod.esewa:
          await _processESewaPayment(
            context,
            selectedSeats,
            passengerDetails,
            eSewaController.text,
          );
          break;
        case PaymentMethod.qrCode:
          await _processQRPayment(context, selectedSeats, passengerDetails);
          break;
        case PaymentMethod.reserveOnly:
          await _processReservation(context, selectedSeats, passengerDetails);
          break;
      }
    } catch (e) {
      state = state.copyWith(isProcessing: false, error: e.toString());
    }
  }

  Future<void> _processESewaPayment(
    BuildContext context,
    List<String> selectedSeats,
    List<Map<String, dynamic>> passengerDetails,
    String eSewaNumber,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final result = await Container();

    if (result == true) {
      state = state.copyWith(isProcessing: false);
    } else {
      state = state.copyWith(isProcessing: false);
    }
  }

  Future<void> _processQRPayment(
    BuildContext context,
    List<String> selectedSeats,
    List<Map<String, dynamic>> passengerDetails,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final result = await Container();

    if (result == true) {
      state = state.copyWith(isProcessing: false);
    } else {
      state = state.copyWith(isProcessing: false);
    }
  }

  Future<void> _processReservation(
    BuildContext context,
    List<String> selectedSeats,
    List<Map<String, dynamic>> passengerDetails,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(isProcessing: false);
  }

  Widget buildESewaOption(
    PaymentState paymentState,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              paymentState.selectedPaymentMethod == PaymentMethod.esewa
                  ? AppColors.mainColor
                  : AppColors.gray300,
          width:
              paymentState.selectedPaymentMethod == PaymentMethod.esewa ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          RadioListTile<PaymentMethod>(
            value: PaymentMethod.esewa,
            groupValue: paymentState.selectedPaymentMethod,
            onChanged: (value) => selectPaymentMethod(value!),
            title: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "eSewa",
                        type: TextType.titleMedium,
                        fontWeight: FontWeight.w600,
                      ),
                      CText(
                        "Pay securely with your eSewa digital wallet",
                        type: TextType.bodyMedium,
                        color: AppColors.gray700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          if (paymentState.selectedPaymentMethod == PaymentMethod.esewa) ...[
            const Divider(color: AppColors.gray300),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CText(
                    "eSewa Number",
                    type: TextType.bodyMedium,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray800,
                  ),
                  AppSpacing.verticalSpaceSmall,
                  CustTextField(
                    controller: controller,
                    hintText: "Enter your eSewa number",
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // QR Code Payment Option Widget
  Widget buildQRCodeOption(PaymentState paymentState) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              paymentState.selectedPaymentMethod == PaymentMethod.qrCode
                  ? AppColors.mainColor
                  : AppColors.gray300,
          width:
              paymentState.selectedPaymentMethod == PaymentMethod.qrCode
                  ? 2
                  : 1,
        ),
      ),
      child: Column(
        children: [
          RadioListTile<PaymentMethod>(
            value: PaymentMethod.qrCode,
            groupValue: paymentState.selectedPaymentMethod,
            onChanged: (value) => selectPaymentMethod(value!),
            title: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.gray200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: CustomPaint(
                      size: const Size(16, 16),
                      painter: QRCodePainter(),
                    ),
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "QR Code Payment",
                        type: TextType.titleMedium,
                        fontWeight: FontWeight.w600,
                      ),
                      CText(
                        "Scan QR code to pay with any mobile banking app",
                        type: TextType.bodyMedium,
                        color: AppColors.gray700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          if (paymentState.selectedPaymentMethod == PaymentMethod.qrCode) ...[
            const Divider(color: AppColors.gray300),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.gray300),
                    ),
                    child: CustomPaint(
                      size: const Size(140, 140),
                      painter: QRCodePainter(),
                    ),
                  ),
                  AppSpacing.verticalSpaceMedium,
                  const CText(
                    "QR Code will be generated after confirmation",
                    type: TextType.bodyMedium,
                    color: AppColors.gray600,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Reservation Option Widget
  Widget buildReservationOption(PaymentState paymentState) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              paymentState.selectedPaymentMethod == PaymentMethod.reserveOnly
                  ? AppColors.mainColor
                  : AppColors.gray300,
          width:
              paymentState.selectedPaymentMethod == PaymentMethod.reserveOnly
                  ? 2
                  : 1,
        ),
      ),
      child: Column(
        children: [
          RadioListTile<PaymentMethod>(
            value: PaymentMethod.reserveOnly,
            groupValue: paymentState.selectedPaymentMethod,
            onChanged: (value) => selectPaymentMethod(value!),
            title: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.schedule,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "Reserve Only",
                        type: TextType.titleMedium,
                        fontWeight: FontWeight.w600,
                      ),
                      CText(
                        "Reserve seats now, pay later at the counter",
                        type: TextType.bodyMedium,
                        color: AppColors.gray700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          if (paymentState.selectedPaymentMethod ==
              PaymentMethod.reserveOnly) ...[
            const Divider(color: AppColors.gray300),
            ReservationTerms(),
          ],
        ],
      ),
    );
  }

  void reset() {
    state = PaymentState();
  }
}

class QRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.gray600
          ..style = PaintingStyle.fill;

    final squareSize = size.width / 8;
    final pattern = [
      [1, 1, 1, 0, 0, 1, 1, 1],
      [1, 0, 1, 0, 1, 1, 0, 1],
      [1, 0, 1, 1, 0, 1, 0, 1],
      [0, 0, 0, 1, 1, 0, 0, 0],
      [0, 1, 0, 0, 1, 0, 1, 0],
      [1, 1, 1, 0, 1, 1, 1, 1],
      [1, 0, 1, 1, 0, 1, 0, 1],
      [1, 1, 1, 0, 1, 1, 1, 1],
    ];

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (pattern[i][j] == 1) {
          canvas.drawRect(
            Rect.fromLTWH(
              j * squareSize,
              i * squareSize,
              squareSize,
              squareSize,
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
