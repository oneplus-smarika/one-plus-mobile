import 'package:flutter/material.dart';
import 'package:oneplus_app/core/core.dart';

///test Custom text , textField,  spacing , buttons, methods, appBar, image
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Test Page'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ///text
              CText('Test Page', type: TextType.titleLarge),
              AppSpacing.verticalSpaceMedium,

              ///text field
              CustTextField(controller: emailController, hintText: 'Email'),
              AppSpacing.verticalSpaceMedium,

              ///Image
              Image.asset(AppAssets.appLogo),
              AppSpacing.verticalSpaceMedium,
              ReusableButton(
                text: "Continue",
                onPressed: () {
                  AppMethods.showCustomSnackBar(
                    context: context,
                    message: 'Hi, welcome to the one plus app...',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
