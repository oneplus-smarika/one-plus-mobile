import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneplus_app/core/core.dart';
import 'package:oneplus_app/feat/home/presentation/pages/home_page.dart';
import '../controller/register_controller.dart';
import '../provider/auth_provider.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(registerControllerProvider);
    final gender = ref.watch(genderProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.appLogo,
                  height: 250,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
                const CText(
                  'Lets Get Started',
                  type: TextType.titleMedium,
                  textAlign: TextAlign.start,
                ),
                AppSpacing.verticalSpaceTiny,
                const CText(
                  'Fill Up Your Personal Information',
                  type: TextType.titleMedium,
                  textAlign: TextAlign.start,
                ),
                AppSpacing.verticalSpaceLarge,
                CustTextField(
                  controller: controller.fullNameController,
                  headerWidget: const CText(
                    "Full Name",
                    type: TextType.bodyMedium,
                  ),
                ),
                AppSpacing.verticalSpaceLarge,
                Align(
                  alignment: Alignment.centerLeft,
                  child: const CText('Gender', type: TextType.bodyMedium),
                ),
                AppSpacing.verticalSpaceSmall,
                DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(12.0),
                  isExpanded: true,
                  value: gender,
                  items:
                      ['Female', 'Male', 'Other']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) controller.updateGender(value);
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.mainColor),
                    ),
                    contentPadding: EdgeInsets.all(12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.textColor1),
                    ),
                  ),
                ),
                AppSpacing.verticalSpaceLarge,
                CustTextField(
                  headerWidget: const CText(
                    "Contact Number",
                    type: TextType.bodyMedium,
                  ),
                  keyboardType: TextInputType.phone,
                  controller: controller.contactNumberController,
                ),
                AppSpacing.verticalSpaceLarge,
                ReusableButton(
                  text: "Finish",
                  onPressed: () {
                    controller.submit();
                    AppMethods.showLoaderDialog(context, txt: "Loading...");
                    Future.delayed(const Duration(seconds: 2), () {
                      AppMethods.dismissLoaderDialog(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      }));
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
