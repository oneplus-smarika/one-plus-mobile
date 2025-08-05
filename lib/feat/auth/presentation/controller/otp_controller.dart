import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:oneplus_app/core/core.dart';

import '../pages/register_page.dart';
import '../provider/auth_provider.dart';


// Controller class for OTP handling
class OtpController {
  final Ref ref;

  OtpController(this.ref);

  // Update OTP input value
  void updateOtp(String value) {
    ref.read(otpProvider.notifier).state = value;
  }

  // Verify OTP logic
  void verifyOtp(BuildContext context) {
    final enteredOtp = ref.read(otpProvider);
    const correctOtp = '123456'; // This should come from backend API ideally

    if (enteredOtp == correctOtp) {
      ref.read(otpVerificationStateProvider.notifier).state = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
      AppMethods.showCustomSnackBar(context: context, message: "OTP Verified");
      // Navigate to next screen or perform success action here
    } else {
      ref.read(otpVerificationStateProvider.notifier).state = false;
      AppMethods.showCustomSnackBar(context: context, message: 'Invalid OTP');
    }
  }
}

// Provider for the OtpController
final otpControllerProvider = Provider((ref) => OtpController(ref));
