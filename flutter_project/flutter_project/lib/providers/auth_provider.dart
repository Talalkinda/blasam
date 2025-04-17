import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _phoneNumber;
  String? _userName;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get userId => _userId;
  String? get phoneNumber => _phoneNumber;
  String? get userName => _userName;

  // Check if user is already authenticated
  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('userData');
      
      if (userData != null) {
        final extractedData = json.decode(userData) as Map<String, dynamic>;
        final expiryDate = DateTime.parse(extractedData['expiryDate']);
        
        if (expiryDate.isAfter(DateTime.now())) {
          _token = extractedData['token'];
          _userId = extractedData['userId'];
          _phoneNumber = extractedData['phoneNumber'];
          _userName = extractedData['userName'];
          _isAuthenticated = true;
        }
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Send OTP to phone number
  Future<void> sendOtp(String phoneNumber) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call to send OTP
      // For demo purposes, we'll simulate a successful response
      await Future.delayed(const Duration(seconds: 1));
      
      _phoneNumber = phoneNumber;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call to verify OTP
      // For demo purposes, we'll simulate a successful response if OTP is '123456'
      await Future.delayed(const Duration(seconds: 1));
      
      if (otp == '123456') {
        // Simulate successful authentication
        _token = 'dummy_token';
        _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
        _phoneNumber = phoneNumber;
        _userName = 'مستخدم جديد';
        _isAuthenticated = true;
        
        // Save auth data to device
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'userId': _userId,
          'phoneNumber': _phoneNumber,
          'userName': _userName,
          'expiryDate': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        });
        prefs.setString('userData', userData);
        
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Register new user
  Future<void> register(String name, String phoneNumber) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call to register user
      // For demo purposes, we'll simulate a successful response
      await Future.delayed(const Duration(seconds: 1));
      
      _phoneNumber = phoneNumber;
      _userName = name;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    _token = null;
    _userId = null;
    _phoneNumber = null;
    _userName = null;
    _isAuthenticated = false;
    
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    
    notifyListeners();
  }

  // Update user profile
  Future<void> updateProfile(String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call to update profile
      // For demo purposes, we'll simulate a successful response
      await Future.delayed(const Duration(seconds: 1));
      
      _userName = name;
      
      // Update stored data
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'phoneNumber': _phoneNumber,
        'userName': _userName,
        'expiryDate': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
