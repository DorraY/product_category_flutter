import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';


class ProductService {
  final String productURL = "http://localhost:6666/products/";
  var client = http.Client();

  Future<List<Product>> getProducts() async {

    List<Product> products= [];

    final response = await http
        .get(Uri.parse(productURL+ 'all-products'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      List<dynamic> productsJsonList = json.decode(response.body);
      productsJsonList.forEach((productJson) {
        products.add(Product.fromJson(productJson));
      });
      return products;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load products');
    }
  }



}