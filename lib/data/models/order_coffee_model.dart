class OrderCoffeeModel {
  String name;
  String type;
  double price;
  int count;
  String imageUrl;

  OrderCoffeeModel({
    required this.name,
    required this.type,
    required this.price,
    required this.count,
    required this.imageUrl,
  });

  factory OrderCoffeeModel.fromMap(Map<String, dynamic> map) {
    return OrderCoffeeModel(
      name: map['name'],
      type: map['type'],
      price: map['price'].toDouble(),
      count: map['count'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'price': price,
      'count': count,
      'imageUrl': imageUrl,
    };
  }

  @override
  String toString() {
    return '''
    CoffeeModel{
     name: $name,
     type: $type,
     price: $price,
     count: $count,
     imageUrl: $imageUrl
     }''';
  }
}
