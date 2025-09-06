import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromRGBO(252, 222, 186, 1),
  primaryColor: const Color(0xFFFE7400),
  colorScheme: const ColorScheme.light(
    primary: Color.fromRGBO(254, 116, 0, 1.0),
    secondary: Color.fromRGBO(53, 151, 0, 1),
    tertiary: Colors.white,
    tertiaryFixed: Colors.black
  ),
  cardColor: Color(0xFFC2E4B0),



  textTheme: TextTheme(

    bodyLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.white
    ),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Colors.white
    ),
    bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white
    ),

    titleLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    ),

    labelLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),

    labelMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(53, 151, 0, 1),
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(254, 116, 0, 1.0),
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromRGBO(226, 242, 217, 1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color.fromRGBO(249, 207, 1, 1),
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color.fromRGBO(249, 207, 1, 1),
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color.fromRGBO(249, 207, 1, 1),
        width: 1,
      ),
    ),
  ),
  extensions: <ThemeExtension<dynamic>>[
    const AppColors(
      homeBackground: Color.fromRGBO(252, 222, 186, 1),
      primaryButton: Color.fromRGBO(53, 151, 0, 1),
      secondaryButton: Color.fromRGBO(254, 116, 0, 1.0),
      unselectedButton: Color.fromRGBO(194, 228, 176, 1),
      unselectedButtonBorder: Color.fromRGBO(194, 228, 176, 1),
      messageBackground: Color.fromRGBO(194, 228, 176, 1),
      noticeBackground: Color.fromRGBO(54, 186, 23, 1),
      sectionBackground: Color.fromRGBO(194, 228, 176, 1),
      progressColor: Color.fromRGBO(254, 116, 0, 1.0),
    ),
  ],
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromRGBO(44, 40, 46, 1),
  primaryColor: const Color.fromRGBO(254, 116, 0, 1.0),
  colorScheme: const ColorScheme.dark(
    primary: Color.fromRGBO(254, 116, 0, 1.0),
    secondary: Color.fromRGBO(53, 151, 0, 1),
    tertiary: Colors.white,
    tertiaryFixed: Colors.white
  ),
  cardColor: Color(0xFFC2E4B0),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(53, 151, 0, 1),
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(254, 116, 0, 1.0),
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromRGBO(226, 242, 217, 1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color.fromRGBO(249, 207, 1, 1),
        width: 1,
      ),
    ),
  ),
  extensions: <ThemeExtension<dynamic>>[
    const AppColors(
      homeBackground: Color.fromRGBO(44, 40, 46, 1),
      primaryButton: Color.fromRGBO(53, 151, 0, 1),
      secondaryButton: Color.fromRGBO(254, 116, 0, 1.0),
      unselectedButton: Color.fromRGBO(194, 228, 176, 1),
      unselectedButtonBorder: Color.fromRGBO(194, 228, 176, 1),
      messageBackground: Color.fromRGBO(194, 228, 176, 1),
      noticeBackground: Color.fromRGBO(54, 186, 23, 1),
      sectionBackground: Color.fromRGBO(194, 228, 176, 1),
      progressColor: Color.fromRGBO(254, 116, 0, 1.0),
    ),
  ],
);

class AppColors extends ThemeExtension<AppColors> {
  final Color homeBackground;
  final Color primaryButton;
  final Color secondaryButton;
  final Color unselectedButton;
  final Color unselectedButtonBorder;
  final Color messageBackground;
  final Color noticeBackground;
  final Color sectionBackground;
  final Color progressColor;

  const AppColors({
    required this.homeBackground,
    required this.primaryButton,
    required this.secondaryButton,
    required this.unselectedButton,
    required this.unselectedButtonBorder,
    required this.messageBackground,
    required this.noticeBackground,
    required this.sectionBackground,
    required this.progressColor,
  });

  @override
  AppColors copyWith({
    Color? homeBackground,
    Color? primaryButton,
    Color? secondaryButton,
    Color? unselectedButton,
    Color? unselectedButtonBorder,
    Color? messageBackground,
    Color? noticeBackground,
    Color? sectionBackground,
    Color? progressColor,
  }) {
    return AppColors(
      homeBackground: homeBackground ?? this.homeBackground,
      primaryButton: primaryButton ?? this.primaryButton,
      secondaryButton: secondaryButton ?? this.secondaryButton,
      unselectedButton: unselectedButton ?? this.unselectedButton,
      unselectedButtonBorder:
      unselectedButtonBorder ?? this.unselectedButtonBorder,
      messageBackground: messageBackground ?? this.messageBackground,
      noticeBackground: noticeBackground ?? this.noticeBackground,
      sectionBackground: sectionBackground ?? this.sectionBackground,
      progressColor: progressColor ?? this.progressColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      homeBackground: Color.lerp(homeBackground, other.homeBackground, t)!,
      primaryButton: Color.lerp(primaryButton, other.primaryButton, t)!,
      secondaryButton: Color.lerp(secondaryButton, other.secondaryButton, t)!,
      unselectedButton:
      Color.lerp(unselectedButton, other.unselectedButton, t)!,
      unselectedButtonBorder:
      Color.lerp(unselectedButtonBorder, other.unselectedButtonBorder, t)!,
      messageBackground:
      Color.lerp(messageBackground, other.messageBackground, t)!,
      noticeBackground:
      Color.lerp(noticeBackground, other.noticeBackground, t)!,
      sectionBackground:
      Color.lerp(sectionBackground, other.sectionBackground, t)!,
      progressColor: Color.lerp(progressColor, other.progressColor, t)!,
    );
  }
}
