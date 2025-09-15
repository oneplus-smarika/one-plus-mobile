import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class AppThemes {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Manrope',
    // Changed from Inter to Manrope
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mainColor,
      brightness: Brightness.light,
      primary: AppColors.mainColor,
      secondary: AppColors.secondaryColor,
      background: AppColors.backgroundColor,
      surface: AppColors.cardColor2,
    ),

    scaffoldBackgroundColor: AppColors.backgroundColor,
    // scaffoldBackgroundColor: AppColors.white,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      color: AppColors.mainColor,
      iconTheme: IconThemeData(color: AppColors.textColor4),
      titleTextStyle: TextStyle(
        color: AppColors.textColor4,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Text Themes with specified sizes and weights
    textTheme: GoogleFonts.manropeTextTheme(
      const TextTheme(
        // Course titles, main headings
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          letterSpacing: -0.5,
        ),
        // Section headings
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor3,
        ),
        // Subsection headings
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor3,
        ),
        // Course description, important content
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor1,
          height: 1.5,
        ),
        // Lesson titles, card headings
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor1,
          height: 1.4,
        ),
        // Secondary information
        titleSmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor1,
        ),
        // Main content text
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor1,
          height: 1.6,
        ),
        // Regular content, descriptions
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor1,
          height: 1.5,
        ),
        // Captions, metadata
        bodySmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor2,
          height: 1.4,
        ),
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColor,
        foregroundColor: AppColors.textColor4,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Card Theme

    cardTheme: const CardThemeData(
      color:  AppColors.cardColor2,
      surfaceTintColor:  AppColors.cardColor2,
      elevation: 2,
      shadowColor:  AppColors.cardColor2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.searchBarColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        color: AppColors.textColor2,
      ),
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.cardColor2,
      surfaceTintColor: AppColors.cardColor2,
    ),

    // Dialog Theme
    // dialogTheme: DialogTheme(
    //     backgroundColor: AppColors.cardColor2,
    //   titleTextStyle: TextStyle(
    //     color: AppColors.textColor1,
    //     fontSize: 20,
    //     fontWeight: FontWeight.w600,
    //   ),
    // ),
  );
}
