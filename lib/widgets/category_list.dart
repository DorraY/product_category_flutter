import 'package:flutter/material.dart';

import 'package:product_category/models/category.dart';
import 'package:product_category/widgets/category_item.dart';

class CategoryList extends StatelessWidget {

  final List<Category> categories;
  final Function deleteCategory;
  final Function editCategoryModalSheet;


  CategoryList(
      this.categories, this.deleteCategory, this.editCategoryModalSheet);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height,
      child: categories.isEmpty
          ? LayoutBuilder(
          builder: (context, constraints) => Column(
            children: <Widget>[
              Text(
                'No categories yet',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ))
          : ListView.builder(
          itemBuilder: (ctx, index) => CategoryItem(
              categories[index], deleteCategory,
              editCategoryModalSheet),
          itemCount: categories.length),
    );
  }
}
