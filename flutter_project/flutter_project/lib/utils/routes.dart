import 'package:flutter/material.dart';
import 'package:car_marketplace/screens/auth/login_screen.dart';
import 'package:car_marketplace/screens/auth/otp_screen.dart';
import 'package:car_marketplace/screens/auth/register_screen.dart';
import 'package:car_marketplace/screens/home/home_screen.dart';
import 'package:car_marketplace/screens/car/car_detail_screen.dart';
import 'package:car_marketplace/screens/car/add_car_screen.dart';
import 'package:car_marketplace/screens/wallet/wallet_screen.dart';
import 'package:car_marketplace/screens/profile/profile_screen.dart';
import 'package:car_marketplace/screens/subscription/subscription_screen.dart';
import 'package:car_marketplace/screens/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> get routes {
    return {
      '/': (context) => const SplashScreen(),
      '/login': (context) => const LoginScreen(),
      '/otp': (context) => const OtpScreen(),
      '/register': (context) => const RegisterScreen(),
      '/home': (context) => const HomeScreen(),
      '/car-detail': (context) => const CarDetailScreen(),
      '/add-car': (context) => const AddCarScreen(),
      '/wallet': (context) => const WalletScreen(),
      '/profile': (context) => const ProfileScreen(),
      '/subscription': (context) => const SubscriptionScreen(),
    };
  }
}
