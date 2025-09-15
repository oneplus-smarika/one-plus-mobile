import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneplus_app/core/core.dart';
import 'package:pinput/pinput.dart';
import '../controller/otp_controller.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = ref.read(otpControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('OTP')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.onePlusLogo,
              height:70,
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
            AppSpacing.verticalSpaceLarge,
            const CText(
              'We have sent you OTP on your number',
              textAlign: TextAlign.center,
              type: TextType.bodyLarge,
            ),
            AppSpacing.verticalSpaceSmall,
            const CText(
              'Please Enter OTP here',
              textAlign: TextAlign.center,
              type: TextType.titleMedium,
            ),
            AppSpacing.verticalSpaceLarge,
            Pinput(
              length: 6,
              onCompleted: otpController.updateOtp,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(fontSize: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            AppSpacing.verticalSpaceLarge,
            ReusableButton(
              text: 'Continue',
              onPressed: () => otpController.verifyOtp(context),
            ),
          ],
        ),
      ),
    );
  }
}
