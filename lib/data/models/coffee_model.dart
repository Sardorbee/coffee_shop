class CoffeeModel {
  String coffeeId; // Make it non-required
  String name;
  String type;
  double price;
  String imageUrl;
  String description;
  String createdAt;

  CoffeeModel({
    required this.name,
    required this.type,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.createdAt,
    this.coffeeId = '', // Provide a default value (e.g., an empty string)
  });

  CoffeeModel copyWith({
    String? coffeeId, // Update the copyWith method to include coffeeId
    String? name,
    String? type,
    double? price,
    String? imageUrl,
    String? description,
    String? createdAt,
  }) {
    return CoffeeModel(
      coffeeId: coffeeId ?? this.coffeeId,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CoffeeModel.fromMap(Map<String, dynamic> map) {
    return CoffeeModel(
      coffeeId: map['coffeeId'] ?? '', // Provide a default value in case it's not in the map
      name: map['name'],
      type: map['type'],
      price: map['price'].toDouble(),
      imageUrl: map['imageUrl'],
      description: map['description'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coffeeId': coffeeId, // Include coffeeId in the toMap method
      'name': name,
      'type': type,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'created_at': createdAt,
    };
  }

  @override
  String toString() {
    return '''
    CoffeeModel{
     coffeeId: $coffeeId,
     name: $name,
     type: $type,
     price: $price,
     imageUrl: $imageUrl,
     description: $description,
     created_at: $createdAt
     }''';
  }
}
