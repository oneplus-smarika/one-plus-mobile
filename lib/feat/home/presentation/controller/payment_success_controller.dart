import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PaymentSuccessData {
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

  PaymentSuccessData({
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
}

class PaymentSuccessState {
  final PaymentSuccessData data;
  final bool isLoading;
  final String? errorMessage;

  PaymentSuccessState({
    required this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  PaymentSuccessState copyWith({
    PaymentSuccessData? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PaymentSuccessState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class PaymentSuccessController extends StateNotifier<PaymentSuccessState> {
  PaymentSuccessController(PaymentSuccessData data)
    : super(PaymentSuccessState(data: data));

  bool get isReservation =>
      state.data.paymentMethod.toLowerCase() == 'reserve only';

  String get paymentStatusText => isReservation ? "Reserved" : "Confirmed";

  String get headerTitle =>
      isReservation ? "Seats Reserved!" : "Payment Successful!";

  String get headerSubtitle =>
      isReservation
          ? "Complete payment at the bus counter"
          : "Your bus ticket has been confirmed";

  String get confirmationTitle =>
      isReservation ? "Reservation Confirmed" : "Booking Confirmed";

  String get seatStatusText =>
      "${state.data.selectedSeats.length} seat(s) ${isReservation ? 'reserved' : 'confirmed'}";

  String formatCurrency(double amount) {
    return "NPR ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}";
  }

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy, hh:mm:ss a');
    return formatter.format(dateTime);
  }

  String getPaymentMethodDisplay() {
    switch (state.data.paymentMethod.toLowerCase()) {
      case 'esewa':
        return 'eSewa';
      case 'qr code':
        return 'QR Code';
      case 'reserve only':
        return 'Reserve Only';
      default:
        return state.data.paymentMethod;
    }
  }

  double get remainingAmount =>
      (state.data.totalAmount ?? 0) - state.data.amountPaid;

  String get reservationExpiryText {
    if (!isReservation || state.data.reservationExpiry == null) return '';
    return "Valid until: ${formatDateTime(state.data.reservationExpiry!)}";
  }

  String get paymentRequiredText {
    return "You need to pay ${formatCurrency(state.data.totalAmount ?? 0)} at the bus counter before departure.";
  }

  Future<void> copyBookingId() async {
    try {
      state = state.copyWith(isLoading: true);
      await Clipboard.setData(ClipboardData(text: state.data.bookingId));
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Failed to copy booking ID",
      );
    }
  }

  Future<void> shareBookingDetails() async {
    try {
      state = state.copyWith(isLoading: true);

      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Failed to share booking details",
      );
    }
  }

  Future<void> downloadTicket() async {
    try {
      state = state.copyWith(isLoading: true);

      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Failed to download ticket",
      );
    }
  }

  Future<void> shareTicket() async {
    try {
      state = state.copyWith(isLoading: true);

      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Failed to share ticket",
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  static List<String> getPaymentInstructions() {
    return [
      "Visit the bus counter at least 1 hour before departure",
      "Show this booking confirmation to the counter staff",
      "Pay the remaining amount and collect your tickets",
      "Carry valid photo ID proof for verification",
    ];
  }

  static List<Map<String, String>> getTripDetails(PaymentSuccessData data) {
    return [
      {"label": "Route", "value": data.route},
      {"label": "Bus Operator", "value": "One Plus Yatayat"},
      {"label": "Bus Type", "value": "Sleeper Bus"},
      {"label": "Travel Date", "value": data.date},
      {"label": "Departure", "value": data.departureTime},
      {"label": "Arrival", "value": data.arrivalTime},
    ];
  }
}

final paymentSuccessControllerProvider = StateNotifierProvider.autoDispose
    .family<PaymentSuccessController, PaymentSuccessState, PaymentSuccessData>(
      (ref, data) => PaymentSuccessController(data),
    );

final isReservationProvider = Provider.autoDispose
    .family<bool, PaymentSuccessData>(
      (ref, data) =>
          ref
              .watch(paymentSuccessControllerProvider(data).notifier)
              .isReservation,
    );

final paymentStatusProvider = Provider.autoDispose
    .family<String, PaymentSuccessData>(
      (ref, data) =>
          ref
              .watch(paymentSuccessControllerProvider(data).notifier)
              .paymentStatusText,
    );

final formattedAmountProvider = Provider.autoDispose.family<String, double>(
  (ref, amount) =>
      "NPR ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
);
