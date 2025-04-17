import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: const Color(0xFF1976D2),
      hintColor: const Color(0xFF42A5F5),
      fontFamily: 'Tajawal',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
        bodyLarge: TextStyle(fontSize: 14.0),
        bodyMedium: TextStyle(fontSize: 14.0),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF1976D2),
          side: const BorderSide(color: Color(0xFF1976D2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF1976D2),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        filled: true,
        fillColor: Colors.white,
      ),
      cardTheme: CardTheme(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        secondary: const Color(0xFF42A5F5),
        background: const Color(0xFFF5F5F5),
      ),
    );
  }
}
