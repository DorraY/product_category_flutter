import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_category/models/category.dart';


class CategoryService {
  final String categoryURL = "http://localhost:6666/category/";
  var client = http.Client();

  Future<List<Category>> getCategories() async {
    List<Category> categories= [];

    final response = await http
        .get(Uri.parse(categoryURL+'all-categories'),
      headers: {'Access-Control-Allow-Origin': "*",
        "Accept": "application/json",
      });

    if (response.statusCode == 200) {
      List<dynamic> categoriesJsonList = json.decode(response.body);
      categoriesJsonList.forEach((categoryJson) {
        categories.add(Category.fromJson(categoryJson));
      });
      return categories;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load categories');
    }
  }

  Future<Category> addCategory(String newCategoryTitle) async {
    Category addedCategory;

    print(newCategoryTitle);
    final response = await http
        .post(Uri.parse(categoryURL+'new-category'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        },body: {
          "title": newCategoryTitle
        });
    if (response.statusCode == 201) {
      addedCategory = Category.fromJson(json.decode(response.body));
      return addedCategory;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to add category');
    }
  }



}