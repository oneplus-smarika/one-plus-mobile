import 'package:flutter/material.dart';

class AppColors {
  /// Main Colors
  static const Color mainColor = Color(0xFF0A3D62);
  static const Color secondaryColor = Color(0xFFFFFFFF);

  /// Background Colors
  static const Color backgroundColor = Color(0xFFF7F8FF);
  static const Color searchBarColor = Color(0xFFF0F2F8);
  static const Color footerColor = Color(0xFFEDEFFA);
  static const Color cardColor = Color(0xFFFAF7F7);

  /// Hover Colors
  static const Color hoverColor1 = Color(0xFF0D3F8B);
  static const Color hoverColor2 = Color(0xFF0D3F8B);
  static const Color hoverColor3 = Color(0xFF0D3F8B);

  /// Card Colors
  static const Color cardColor1 = Color(0xFFF5F5F5);
  static const Color cardColor2 = Color(0xFFFFFFFF);

  ///failure
  static const Color failure = Color(0xFFBD0404);
  static const Color flag = Color(0xFFC50303);

  ///success
  static const Color success = Color(0xFF49A84D);
  static const Color orange = Color(0xF5FF8000);
  static const Color orangeLight = Color(0xF5FAF1E1);

  //success

  ///gray
  static const Color gray900 = Color(0xFF1A2632); // Very dark blue-grey
  static const Color gray800 = Color(0xFF2D3B47); // Dark blue-grey
  static const Color gray700 = Color(0xFF3D4D5C); // Medium-dark blue-grey
  static const Color gray600 = Color(0xFF556575); // Medium blue-grey
  static const Color gray500 = Color(0xFF7B8A99); // Medium blue-grey
  static const Color gray400 = Color(0xFFA3AEB9); // Light blue-grey
  static const Color gray300 = Color(0xFFCFD6DE); // Lighter blue-grey
  static const Color gray200 = Color(0xFFE2E8ED); // Very light blue-grey
  static const Color gray100 = Color(0xFFF0F4F8); // Extremely light blue-grey

  /// Text Colors
  static const Color textColor1 = Color(0xFF444655);
  static const Color textColor2 = Color(0xFF747687);
  static const Color textColor3 = Color(0xFF3958A8);
  static const Color textColor4 = Color(0xFFFFFFFF);
  static const Color descTextColor = Color(0xFF231F20);
  static const Color hintTextColor = gray500; // Color(0xFF7B8A99)

  /// Utility Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Gradient
  static const LinearGradient mainGradient = LinearGradient(
    colors: [mainColor, hoverColor1],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Color List for Dynamic Elements
  static const List<Color> dynamicColors = [
    mainColor,
    secondaryColor,
    hoverColor1,
    cardColor1,
    cardColor2,
    textColor1,
    textColor2,
    textColor3,
  ];
  static ({
  Color iconColor,
  Color textColor,
  Color containerColor,
  Color borderColor,
  })
  getColors(bool showingImage) {
    return (
    iconColor: showingImage ? AppColors.white : AppColors.gray800,
    textColor: showingImage ? AppColors.white : AppColors.gray800,
    containerColor:
    showingImage
        ? Colors.black12.withValues(alpha: 0.2)
        : AppColors.gray100.withValues(alpha: 0.9),
    borderColor:
    showingImage
        ? AppColors.white.withValues(alpha: 0.3)
        : AppColors.gray300.withValues(alpha: 0.5),
    );
  }
}
