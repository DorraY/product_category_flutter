import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';


class ProductService {
  final String productURL = "http://localhost:6666/product/";
  var client = http.Client();

  Future<List<Product>> getProducts() async {
    List<Product> products= [];

    final response = await http
        .get(Uri.parse('${productURL}all-products'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      List<dynamic> productsJsonList = json.decode(response.body);
      for (var productJson in productsJsonList) {
        print(productJson);
        products.add(Product.fromJson(productJson));
      }
      return products;
    } else {
      throw Exception('Failed to load categories');
    }
  }



}