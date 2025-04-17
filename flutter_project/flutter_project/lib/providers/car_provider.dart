import 'package:flutter/material.dart';
import 'package:car_marketplace/models/car.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];
  Car? _selectedCar;
  bool _isLoading = false;

  List<Car> get cars => _cars;
  Car? get selectedCar => _selectedCar;
  bool get isLoading => _isLoading;

  // Fetch all cars with optional filters
  Future<void> fetchCars({String? type, String? search}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      // For demo purposes, we'll create some mock data
      await Future.delayed(const Duration(seconds: 1));
      
      final List<Car> mockCars = _generateMockCars();
      
      // Apply filters if provided
      if (type != null && type != 'all') {
        mockCars.removeWhere((car) => car.type != type);
      }
      
      if (search != null && search.isNotEmpty) {
        mockCars.removeWhere((car) => 
          !car.model.toLowerCase().contains(search.toLowerCase()) &&
          !car.make.toLowerCase().contains(search.toLowerCase())
        );
      }
      
      _cars = mockCars;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a single car by ID
  Future<void> fetchCarById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      // For demo purposes, we'll find the car in our mock data
      await Future.delayed(const Duration(seconds: 1));
      
      final List<Car> mockCars = _generateMockCars();
      _selectedCar = mockCars.firstWhere((car) => car.id == id);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new car
  Future<void> addCar(Car car) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      _cars.add(car);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update an existing car
  Future<void> updateCar(Car car) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      final index = _cars.indexWhere((c) => c.id == car.id);
      if (index != -1) {
        _cars[index] = car;
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a car
  Future<void> deleteCar(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      _cars.removeWhere((car) => car.id == id);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Generate mock car data for demo purposes
  List<Car> _generateMockCars() {
    return [
      Car(
        id: '1',
        model: 'كامري',
        make: 'تويوتا',
        year: 2022,
        price: 120000,
        type: 'sale',
        location: 'دمشق',
        mileage: 15000,
        color: 'أبيض',
        fuelType: 'بنزين',
        transmission: 'أوتوماتيك',
        description: 'سيارة تويوتا كامري 2022 بحالة ممتازة، استخدام شخصي، صيانة دورية في الوكالة.',
        images: [
          'https://cdn.pixabay.com/photo/2014/05/18/19/13/toyota-347288_1280.jpg',
        ],
        ownerId: 'user1',
        isFeatured: true,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Car(
        id: '2',
        model: 'أكورد',
        make: 'هوندا',
        year: 2021,
        price: 110000,
        type: 'sale',
        location: 'حلب',
        mileage: 25000,
        color: 'أسود',
        fuelType: 'بنزين',
        transmission: 'أوتوماتيك',
        description: 'هوندا أكورد 2021 بحالة ممتازة، كاملة المواصفات، فتحة سقف، جنط 18.',
        images: [
          'https://cdn.pixabay.com/photo/2016/12/03/18/57/car-1880381_1280.jpg',
        ],
        ownerId: 'user2',
        isFeatured: false,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      Car(
        id: '3',
        model: 'سوناتا',
        make: 'هيونداي',
        year: 2023,
        price: 130000,
        type: 'sale',
        location: 'حمص',
        mileage: 5000,
        color: 'رمادي',
        fuelType: 'بنزين',
        transmission: 'أوتوماتيك',
        description: 'هيونداي سوناتا 2023 جديدة، كاملة المواصفات، ضمان وكالة.',
        images: [
          'https://cdn.pixabay.com/photo/2019/07/07/14/03/fiat-4322521_1280.jpg',
        ],
        ownerId: 'user3',
        isFeatured: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Car(
        id: '4',
        model: 'لاند كروزر',
        make: 'تويوتا',
        year: 2020,
        price: 250000,
        type: 'sale',
        location: 'دمشق',
        mileage: 40000,
        color: 'أبيض',
        fuelType: 'ديزل',
        transmission: 'أوتوماتيك',
        description: 'تويوتا لاند كروزر 2020، فل أوبشن، بحالة الوكالة، صيانة دورية.',
        images: [
          'https://cdn.pixabay.com/photo/2017/03/27/14/56/auto-2179220_1280.jpg',
        ],
        ownerId: 'user4',
        isFeatured: false,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      Car(
        id: '5',
        model: 'إلنترا',
        make: 'هيونداي',
        year: 2022,
        price: 90000,
        type: 'sale',
        location: 'اللاذقية',
        mileage: 18000,
        color: 'أزرق',
        fuelType: 'بنزين',
        transmission: 'أوتوماتيك',
        description: 'هيونداي إلنترا 2022، استخدام شخصي، بحالة ممتازة، صيانة دورية.',
        images: [
          'https://cdn.pixabay.com/photo/2017/01/28/21/48/car-2016738_1280.jpg',
        ],
        ownerId: 'user5',
        isFeatured: false,
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
      Car(
        id: '6',
        model: 'مرسيدس E200',
        make: 'مرسيدس',
        year: 2021,
        price: 5000,
        type: 'rent',
        location: 'دمشق',
        mileage: 30000,
        color: 'أسود',
        fuelType: 'بنزين',
        transmission: 'أوتوماتيك',
        description: 'مرسيدس E200 موديل 2021 متوفرة للإيجار اليومي أو الأسبوعي، بحالة ممتازة.',
        images: [
          'https://cdn.pixabay.com/photo/2016/04/17/22/10/mercedes-benz-1335674_1280.png',
        ],
        ownerId: 'user6',
        isFeatured: true,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Car(
        id: '7',
        model: 'كيا سبورتاج',
        make: 'كيا',
        year: 2022,
        price: 3000,
        type: 'rent',
        location: 'حلب',
        mileage: 20000,
        color: 'أحمر',
        fuelType: 'بنزين',
        transmission: 'أوتوماتيك',
        description: 'كيا سبورتاج 2022 متوفرة للإيجار، مناسبة للرحلات العائلية والسفر.',
        images: [
          'https://cdn.pixabay.com/photo/2018/02/04/15/45/car-3130111_1280.jpg',
        ],
        ownerId: 'user7',
        isFeatured: false,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];
  }
}
