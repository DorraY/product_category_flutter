import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';
import 'package:product_category/widgets/product_list.dart';
class ProductScreen extends StatelessWidget {


  final List<Product> products;
  final List<Category> categories;
  final Function editCategory;
  final Function deleteCategory;


  ProductScreen(this.products,this.categories, this.editCategory, this.deleteCategory);

  @override
  Widget build(BuildContext context) {
    return  ProductList(products,categories, deleteCategory,editCategory);
  }
}
