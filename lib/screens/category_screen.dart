import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/widgets/category_list.dart';
class CategoryScreen extends StatelessWidget {

  final List<Category> _categories;
  final Function editCategory;
  final Function deleteCategory;

  CategoryScreen(this._categories, this.editCategory, this.deleteCategory);

  @override
  Widget build(BuildContext context) {
    return CategoryList(_categories, deleteCategory,editCategory);
  }
}
