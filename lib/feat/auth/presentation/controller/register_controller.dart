import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';

class RegisterController {
  final Ref ref;
  final TextEditingController fullNameController;
  final TextEditingController contactNumberController;

  RegisterController(this.ref)
      : fullNameController = TextEditingController(),
        contactNumberController = TextEditingController() {
    // Sync controllers with Riverpod state
    fullNameController.text = ref.read(fullNameProvider);
    contactNumberController.text = ref.read(contactNumberProvider);

    // Update Riverpod state when text changes
    fullNameController.addListener(() {
      ref.read(fullNameProvider.notifier).state = fullNameController.text;
    });
    contactNumberController.addListener(() {
      ref.read(contactNumberProvider.notifier).state = contactNumberController.text;
    });
  }

  void updateFullName(String value) {
    ref.read(fullNameProvider.notifier).state = value;
  }

  void updateGender(String value) {
    ref.read(genderProvider.notifier).state = value;
  }

  void updateContactNumber(String value) {
    ref.read(contactNumberProvider.notifier).state = value;
  }

  bool validateForm() {
    final name = ref.read(fullNameProvider);
    final contact = ref.read(contactNumberProvider);

    if (name.isEmpty || contact.isEmpty) {
      return false;
    }
    return true;
  }
  void submit() {
    if (!validateForm()) {
      print('Please fill all fields');
      return;
    }

    final name = ref.read(fullNameProvider);
    final gender = ref.read(genderProvider);
    final contact = ref.read(contactNumberProvider);

    print('Registering: $name, $gender, $contact');
    // TODO: Call API / Navigate Next
  }


  // Dispose controllers to prevent memory leaks
  void reset() {
    fullNameController.clear();
    contactNumberController.clear();
  }
}

final registerControllerProvider = Provider.autoDispose((ref) {
  final controller = RegisterController(ref);
  // Ensure controllers are disposed when the provider is destroyed
  ref.onDispose(() => controller.reset());
  return controller;
});