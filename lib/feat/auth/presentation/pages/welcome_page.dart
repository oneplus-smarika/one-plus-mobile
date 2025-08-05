import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneplus_app/core/core.dart';
import '../controller/login_controller.dart';
import '../provider/auth_provider.dart';
import 'otp_page.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(phoneProvider);
    final phoneController = ref.watch(phoneControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.appLogo,height:250, fit: BoxFit.contain),
              const CText('Welcome from,', type: TextType.bodyLarge),
              const CText('Bus App Yatayat', type: TextType.titleLarge),
              AppSpacing.verticalSpaceLarge,
              CustTextField(
                headerWidget: const CText("Enter your number", type: TextType.bodyMedium),
                keyboardType: TextInputType.phone,
                controller: phoneController,
                hintText: '+977 9842467144',
                onFieldChanged: (value) {
                  ref.read(phoneProvider.notifier).state = value;
                },
              ),
              AppSpacing.verticalSpaceLarge,
              ReusableButton(
                text: 'Continue',
                onPressed: () {
                  if (phoneNumber.isNotEmpty) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const OtpPage();
                    }));
                  }
                  else {
                    AppMethods.showCustomSnackBar(
                      context: context,
                      message: 'Please verify your Phone Number',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
