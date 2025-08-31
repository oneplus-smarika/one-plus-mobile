import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passengerFormProvider = StateNotifierProvider.family<PassengerFormController, Map<String, dynamic>, String>((ref, seatNumber) {
  return PassengerFormController(seatNumber);
});

class PassengerFormController extends StateNotifier<Map<String, dynamic>> {
  final String seatNumber;

  PassengerFormController(this.seatNumber)
      : super({
    'name': TextEditingController(),
    'age': TextEditingController(),
    'contact': TextEditingController(),
    'emergencyContact': TextEditingController(),
    'gender': null,
  });

  TextEditingController get nameController => state['name'] as TextEditingController;
  TextEditingController get ageController => state['age'] as TextEditingController;
  TextEditingController get contactController => state['contact'] as TextEditingController;
  TextEditingController get emergencyContactController => state['emergencyContact'] as TextEditingController;
  String? get gender => state['gender'] as String?;

  void updateGender(String? value) {
    state = {...state, 'gender': value};
  }

  void disposeControllers() {
    state['name'].dispose();
    state['age'].dispose();
    state['contact'].dispose();
    state['emergencyContact'].dispose();
    state = {};
  }
}