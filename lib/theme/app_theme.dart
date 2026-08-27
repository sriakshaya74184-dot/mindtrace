import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppColors {

  // PRIMARY
  static const Color primary =
  Color(0xFF4A90E2);

  static const Color background =
  Color(0xFFF7F8FC);

  static const Color card =
      Colors.white;

  // MOOD COLORS
  static const Color moodTerrible =
  Color(0xFFE74C3C);

  static const Color moodBad =
  Color(0xFFFF9800);

  static const Color moodNeutral =
  Color(0xFFFFC107);

  static const Color moodGood =
  Color(0xFF4CAF50);

  static const Color moodGreat =
  Color(0xFF2196F3);

  // TEXT
  static const Color textPrimary =
      Colors.black87;

  static const Color textSecondary =
      Colors.black54;

  static const Color textHint =
      Colors.grey;

  // FUTURISTIC
  static const Color neonCyan =
  Color(0xFF00E5FF);

  static const Color neonPurple =
  Color(0xFF7C4DFF);

  static const Color bgDark =
  Color(0xFF111827);
}

class AppTheme {

  // ================= LIGHT THEME =================

  static ThemeData lightTheme = ThemeData(

    useMaterial3: true,

    fontFamily:
    GoogleFonts.poppins().fontFamily,

    scaffoldBackgroundColor:
    const Color(0xFFF7F8FC),

    primaryColor: Colors.blue,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),

    splashColor: Colors.transparent,

    highlightColor: Colors.transparent,

    // ================= TEXT THEME =================

    textTheme: TextTheme(

      headlineLarge: GoogleFonts.poppins(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),

      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),

      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),

      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.black87,
        height: 1.6,
      ),

      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black54,
        height: 1.5,
      ),
    ),

    // ================= APPBAR =================

    appBarTheme: AppBarTheme(

      backgroundColor: Colors.white,

      elevation: 0,

      centerTitle: true,

      scrolledUnderElevation: 0,

      titleTextStyle:
      GoogleFonts.poppins(

        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),

      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),

    // ================= ELEVATED BUTTON =================

    elevatedButtonTheme:
    ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

        elevation: 0,

        minimumSize:
        const Size(double.infinity, 56),

        padding:
        const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),

        shape: RoundedRectangleBorder(

          borderRadius:
          BorderRadius.circular(20),
        ),

        textStyle:
        GoogleFonts.poppins(

          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ================= INPUT DECORATION =================

    inputDecorationTheme:
    InputDecorationTheme(

      filled: true,

      fillColor: Colors.white,

      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),

      hintStyle:
      GoogleFonts.poppins(
        color: Colors.grey.shade500,
        fontSize: 14,
      ),

      prefixIconColor: Colors.grey,

      suffixIconColor: Colors.grey,

      border: OutlineInputBorder(

        borderRadius:
        BorderRadius.circular(20),

        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(

        borderRadius:
        BorderRadius.circular(20),

        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(

        borderRadius:
        BorderRadius.circular(20),

        borderSide: const BorderSide(
          color: Colors.blue,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(

        borderRadius:
        BorderRadius.circular(20),

        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.2,
        ),
      ),
    ),

    // ================= CARD THEME =================

    cardTheme: CardThemeData(

      color: Colors.white,

      elevation: 2,

      shadowColor: Colors.black12,

      surfaceTintColor: Colors.white,

      shape: RoundedRectangleBorder(

        borderRadius:
        BorderRadius.circular(24),
      ),
    ),

    // ================= DRAWER THEME =================

    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
    ),

    // ================= ICON THEME =================

    iconTheme: const IconThemeData(
      color: Colors.blue,
    ),

    // ================= DIVIDER =================

    dividerTheme: DividerThemeData(
      color: Colors.grey.shade300,
      thickness: 1,
    ),

    // ================= BOTTOM NAVIGATION =================

    bottomNavigationBarTheme:
    const BottomNavigationBarThemeData(

      backgroundColor: Colors.white,

      selectedItemColor: Colors.blue,

      unselectedItemColor: Colors.grey,

      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),

      type: BottomNavigationBarType.fixed,

      elevation: 10,
    ),

    // ================= CHECKBOX =================

    checkboxTheme: CheckboxThemeData(

      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(6),
      ),

      fillColor:
      WidgetStateProperty.resolveWith(

            (states) {

          if (states.contains(
              WidgetState.selected)) {

            return Colors.blue;
          }

          return Colors.white;
        },
      ),
    ),

    // ================= PROGRESS INDICATOR =================

    progressIndicatorTheme:
    const ProgressIndicatorThemeData(
      color: Colors.blue,
    ),
  );
}