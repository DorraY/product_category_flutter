import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/widgets/category_list.dart';
class CategoryScreen extends StatelessWidget {

  final List<Category> categories;
  final Function editCategory;
  final Function deleteCategory;

  CategoryScreen(this.categories, this.editCategory, this.deleteCategory);

  @override
  Widget build(BuildContext context) {
    return CategoryList(categories, deleteCategory,editCategory);
  }
}
