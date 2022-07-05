import 'package:mongo_dart/mongo_dart.dart';

class Resistors {
  Resistors(
    this.id,
    this.name,
    this.value,
    this.quantity,
    this.price,
    this.type,
  );

  Resistors.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        name = map['name'],
        value = map['value'],
        quantity = map['quantity'],
        price = map['price'],
        type = map['type'];
  final ObjectId id;
  final String name;
  final double value;
  final int quantity;
  final double price;
  final String type;

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'value': value,
      'quantity': quantity,
      'price': price,
      'type': type,
    };
  }
}
