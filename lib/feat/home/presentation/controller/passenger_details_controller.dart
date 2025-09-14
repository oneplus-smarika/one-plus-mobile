import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneplus_app/feat/home/presentation/controller/passenger_form_controller.dart';

final passengerDetailsProvider = StateNotifierProvider<
  PassengerDetailsController,
  List<List<TextEditingController>>
>((ref) {
  return PassengerDetailsController();
});

class PassengerDetailsController
    extends StateNotifier<List<List<TextEditingController>>> {
  PassengerDetailsController() : super([]);

  void initControllers(int passengerCount) {
    final controllers = List.generate(
      passengerCount,
      (_) => [
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ],
    );
    state = controllers;
  }

  void disposeControllers() {
    for (var controllers in state) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    state = [];
  }

  List<TextEditingController> getNameControllers() =>
      state.map((c) => c[0]).toList();

  List<TextEditingController> getAgeControllers() =>
      state.map((c) => c[1]).toList();

  List<TextEditingController> getContactControllers() =>
      state.map((c) => c[2]).toList();

  List<TextEditingController> getEmergencyControllers() =>
      state.map((c) => c[3]).toList();

  ValidationResult validatePassengerDetails(
    List<String> selectedSeats,
    WidgetRef ref,
  ) {
    for (int i = 0; i < selectedSeats.length; i++) {
      final formProvider = ref.read(passengerFormProvider(selectedSeats[i]));

      if (formProvider['name'].text.isEmpty ||
          formProvider['age'].text.isEmpty ||
          formProvider['contact'].text.isEmpty ||
          formProvider['gender'] == null) {
        return ValidationResult(
          isValid: false,
          errorMessage:
              'Please fill all required fields for Passenger ${i + 1}',
        );
      }

      final age = int.tryParse(formProvider['age'].text);
      if (age == null || age < 1 || age > 100) {
        return ValidationResult(
          isValid: false,
          errorMessage:
              'Please enter a valid age between 1 and 100 for Passenger ${i + 1}',
        );
      }

      if (formProvider['contact'].text.length < 10) {
        return ValidationResult(
          isValid: false,
          errorMessage:
              'Please enter a valid contact number for Passenger ${i + 1}',
        );
      }

      if (!_isValidPhoneNumber(formProvider['contact'].text)) {
        return ValidationResult(
          isValid: false,
          errorMessage:
              'Please enter a valid phone number for Passenger ${i + 1}',
        );
      }
    }

    return ValidationResult(isValid: true);
  }

  List<Map<String, dynamic>> collectPassengerDetails(
    List<String> selectedSeats,
    WidgetRef ref,
  ) {
    List<Map<String, dynamic>> details = [];

    for (int i = 0; i < selectedSeats.length; i++) {
      final formProvider = ref.read(passengerFormProvider(selectedSeats[i]));

      details.add({
        'name': formProvider['name'].text.trim(),
        'age': formProvider['age'].text.trim(),
        'gender': formProvider['gender'],
        'contact': formProvider['contact'].text.trim(),
        'emergencyContact': formProvider['emergencyContact'].text.trim(),
        'seatNumber': selectedSeats[i],
        'passengerIndex': i + 1,
      });
    }

    return details;
  }

  double calculateTotalAmount(
    List<String> selectedSeats, {
    double pricePerSeat = 2800,
  }) {
    return selectedSeats.length * pricePerSeat;
  }

  String getPassengerSummary(List<String> selectedSeats) {
    return "${selectedSeats.length} seat(s) • One Plus Yatayat";
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanNumber.length == 10 &&
        (cleanNumber.startsWith('9') || cleanNumber.startsWith('8'))) {
      return true;
    }

    if (cleanNumber.length >= 10 && cleanNumber.length <= 15) {
      return true;
    }

    return false;
  }

  void clearAllForms(List<String> selectedSeats, WidgetRef ref) {
    for (int i = 0; i < selectedSeats.length; i++) {
      final formProvider = ref.read(passengerFormProvider(selectedSeats[i]));
      formProvider['name'].clear();
      formProvider['age'].clear();
      formProvider['contact'].clear();
      formProvider['emergencyContact'].clear();
    }
  }

  bool hasUnsavedChanges(List<String> selectedSeats, WidgetRef ref) {
    for (int i = 0; i < selectedSeats.length; i++) {
      final formProvider = ref.read(passengerFormProvider(selectedSeats[i]));
      if (formProvider['name'].text.isNotEmpty ||
          formProvider['age'].text.isNotEmpty ||
          formProvider['contact'].text.isNotEmpty ||
          formProvider['emergencyContact'].text.isNotEmpty ||
          formProvider['gender'] != null) {
        return true;
      }
    }
    return false;
  }
}

class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  ValidationResult({required this.isValid, this.errorMessage});
}
