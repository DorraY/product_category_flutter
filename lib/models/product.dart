import 'package:product_category/models/category.dart';
const backEndUrl = "http://localhost:5000/";
class Product {
  String id;
  String name;
  num price;
  String image;
  DateTime expiryDate;
  Category? category;

  Product(this.id, this.name, this.price,this.expiryDate, this.category,this.image);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['_id'] as String,
      json['name'] as String,
      json['price'] as num,
      DateTime.parse(json['expiryDate']),
      json['category']==null ? null : Category(json!['category']!["_id"],json!['category']!["title"]),
      backEndUrl+json['image'],

    );
  }

}