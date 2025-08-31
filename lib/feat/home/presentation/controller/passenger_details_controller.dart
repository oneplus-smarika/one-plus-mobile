import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passengerDetailsProvider = StateNotifierProvider<PassengerDetailsController, List<List<TextEditingController>>>((ref) {
  return PassengerDetailsController();
});

class PassengerDetailsController extends StateNotifier<List<List<TextEditingController>>> {
  PassengerDetailsController() : super([]);

  void initControllers(int passengerCount) {
    final controllers = List.generate(passengerCount, (_) => [
      TextEditingController(), // name
      TextEditingController(), // age
      TextEditingController(), // contact
      TextEditingController(), // emergency
    ]);
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

  List<TextEditingController> getNameControllers() => state.map((c) => c[0]).toList();
  List<TextEditingController> getAgeControllers() => state.map((c) => c[1]).toList();
  List<TextEditingController> getContactControllers() => state.map((c) => c[2]).toList();
  List<TextEditingController> getEmergencyControllers() => state.map((c) => c[3]).toList();
}