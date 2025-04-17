class Car {
  final String id;
  final String model;
  final String make;
  final int year;
  final double price;
  final String type; // 'sale' or 'rent'
  final String location;
  final double mileage;
  final String color;
  final String fuelType;
  final String transmission;
  final String description;
  final List<String> images;
  final String ownerId;
  final bool isFeatured;
  final DateTime createdAt;

  Car({
    required this.id,
    required this.model,
    required this.make,
    required this.year,
    required this.price,
    required this.type,
    required this.location,
    required this.mileage,
    required this.color,
    required this.fuelType,
    required this.transmission,
    required this.description,
    required this.images,
    required this.ownerId,
    this.isFeatured = false,
    required this.createdAt,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      model: json['model'],
      make: json['make'],
      year: json['year'],
      price: json['price'].toDouble(),
      type: json['type'],
      location: json['location'],
      mileage: json['mileage'].toDouble(),
      color: json['color'],
      fuelType: json['fuel_type'],
      transmission: json['transmission'],
      description: json['description'],
      images: List<String>.from(json['images']),
      ownerId: json['owner_id'],
      isFeatured: json['is_featured'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'make': make,
      'year': year,
      'price': price,
      'type': type,
      'location': location,
      'mileage': mileage,
      'color': color,
      'fuel_type': fuelType,
      'transmission': transmission,
      'description': description,
      'images': images,
      'owner_id': ownerId,
      'is_featured': isFeatured,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
