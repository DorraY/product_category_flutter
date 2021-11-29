import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';


class ProductService {
  final String productURL = "http://localhost:5000/product/";
  var client = http.Client();

  Future<List<Product>> getProducts(String id) async {
    List<Product> products= [];

    final response = await http
        .get(Uri.parse('${productURL}all-products/${id}'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      List<dynamic> productsJsonList = json.decode(response.body);
      for (var productJson in productsJsonList) {
        products.add(Product.fromJson(productJson));
      }
      print(products);
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> addProduct(String newProductName,num newProductPrice,DateTime newProductExpiryDate,Category newProductCategory) async {
    Product addedProduct;
    final response = await http
        .post(Uri.parse('${productURL}new-product'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        },body: {
          "name": newProductName,
          "expiryDate":newProductExpiryDate.toIso8601String(),
          "category": newProductCategory.id,
          "price": newProductPrice.toString()
        });
    if (response.statusCode == 201) {
      addedProduct = Product.fromJson(json.decode(response.body));
      return addedProduct;
    } else {
      throw Exception('Failed to add product');
    }
  }

  Future<Product> updateProduct(String id,String editedProductName, num editedProductPrice, DateTime editedProductExpiryDate,
      Category editedProductCategory
      ) async {
    Product editedProduct;
    final response = await http
        .put(Uri.parse('${productURL}update-product/${id}'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        },body: {
          "name": editedProductName,
          "expiryDate":editedProductExpiryDate.toIso8601String(),
          "category": editedProductCategory.id,
          "price": editedProductPrice.toString()
        });
    if (response.statusCode == 200) {
      editedProduct = Product.fromJson(json.decode(response.body));
      return editedProduct;
    } else {
      throw Exception('Failed to edit product');
    }

  }

  Future<dynamic> deleteProduct(String id) async {
    final response = await http
        .delete(Uri.parse('${productURL}delete-product/${id}'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete product');
    }

  }



}