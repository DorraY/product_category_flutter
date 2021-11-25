import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/widgets/category_list.dart';
class CategoryScreen extends StatelessWidget {

  final List<Category> _categories;


  CategoryScreen(this._categories) ;

  @override
  Widget build(BuildContext context) {

    return CategoryList(_categories, ()=>{}, ()=>{});
  }
}
