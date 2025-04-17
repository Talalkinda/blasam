import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WalletProvider with ChangeNotifier {
  double _balance = 0.0;
  List<Transaction> _transactions = [];
  bool _isLoading = false;

  double get balance => _balance;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;

  // Fetch wallet balance and transactions
  Future<void> fetchWalletData(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      // For demo purposes, we'll simulate a response
      await Future.delayed(const Duration(seconds: 1));
      
      _balance = 25000.0;
      _transactions = _generateMockTransactions();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add funds to wallet
  Future<void> addFunds(double amount) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      _balance += amount;
      _transactions.insert(
        0,
        Transaction(
          id: 'tr_${DateTime.now().millisecondsSinceEpoch}',
          amount: amount,
          type: TransactionType.deposit,
          description: 'إيداع رصيد',
          date: DateTime.now(),
        ),
      );
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Withdraw funds from wallet
  Future<bool> withdrawFunds(double amount) async {
    if (amount > _balance) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      _balance -= amount;
      _transactions.insert(
        0,
        Transaction(
          id: 'tr_${DateTime.now().millisecondsSinceEpoch}',
          amount: amount,
          type: TransactionType.withdrawal,
          description: 'سحب رصيد',
          date: DateTime.now(),
        ),
      );
      return true;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Pay for a service (e.g., featured listing, subscription)
  Future<bool> payForService(double amount, String description) async {
    if (amount > _balance) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      _balance -= amount;
      _transactions.insert(
        0,
        Transaction(
          id: 'tr_${DateTime.now().millisecondsSinceEpoch}',
          amount: amount,
          type: TransactionType.payment,
          description: description,
          date: DateTime.now(),
        ),
      );
      return true;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Generate mock transaction data for demo purposes
  List<Transaction> _generateMockTransactions() {
    return [
      Transaction(
        id: 'tr_1',
        amount: 10000.0,
        type: TransactionType.deposit,
        description: 'إيداع رصيد',
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Transaction(
        id: 'tr_2',
        amount: 2000.0,
        type: TransactionType.payment,
        description: 'اشتراك باقة مميزة',
        date: DateTime.now().subtract(const Duration(days: 4)),
      ),
      Transaction(
        id: 'tr_3',
        amount: 500.0,
        type: TransactionType.payment,
        description: 'إعلان مميز',
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Transaction(
        id: 'tr_4',
        amount: 20000.0,
        type: TransactionType.deposit,
        description: 'إيداع رصيد',
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Transaction(
        id: 'tr_5',
        amount: 2500.0,
        type: TransactionType.withdrawal,
        description: 'سحب رصيد',
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}

enum TransactionType {
  deposit,
  withdrawal,
  payment,
}

class Transaction {
  final String id;
  final double amount;
  final TransactionType type;
  final String description;
  final DateTime date;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.date,
  });
}
