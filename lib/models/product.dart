import 'package:product_category/models/category.dart';

class Product {
  String id;
  String name;
  double price;
  DateTime expiryDate;
  Category category;

  Product(this.id, this.name, this.price, this.expiryDate, this.category);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['_id'] as String,
      json['name'] as String,
      json['price'] as double,
      json['expiryDate'] as DateTime,
      json['category'] as Category,);
  }

}