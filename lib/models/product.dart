import 'package:product_category/models/category.dart';

class Product {
  String id;
  String name;
  double price;
  DateTime expiryDate;
  Category category;

  Product(this.id, this.name, this.price, this.expiryDate, this.category);
}