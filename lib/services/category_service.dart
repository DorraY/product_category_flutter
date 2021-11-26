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
        .get(Uri.parse('${categoryURL}all-categories'),
      headers: {'Access-Control-Allow-Origin': "*",
        "Accept": "application/json",
      });

    if (response.statusCode == 200) {
      List<dynamic> categoriesJsonList = json.decode(response.body);
      for (var categoryJson in categoriesJsonList) {
        categories.add(Category.fromJson(categoryJson));
      }
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Category> addCategory(String newCategoryTitle) async {
    Category addedCategory;
    final response = await http
        .post(Uri.parse('${categoryURL}new-category'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        },body: {
          "title": newCategoryTitle
        });
    if (response.statusCode == 201) {
      addedCategory = Category.fromJson(json.decode(response.body));
      return addedCategory;
    } else {
      throw Exception('Failed to add category');
    }
  }

  Future<Category> updateCategory(String id,String editedCategoryTitle) async {
    Category editedCategory;
    final response = await http
        .put(Uri.parse('${categoryURL}update-category/${id}'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        },body: {
          "title": editedCategoryTitle
        });
    if (response.statusCode == 200) {
      editedCategory = Category.fromJson(json.decode(response.body));
      return editedCategory;
    } else {
      throw Exception('Failed to edit category');
    }

}

  Future<dynamic> deleteCategory(String id) async {
    final response = await http
        .delete(Uri.parse('${categoryURL}delete-category/${id}'),
        headers: {'Access-Control-Allow-Origin': "*",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to edit category');
    }

  }



}