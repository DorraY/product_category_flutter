import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';
import 'package:product_category/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../models/product_list.dart' as prod_provider;


class ProductList extends StatelessWidget {


  final List<Product> products;
  final List<Category> categories;

  ProductList(this.products,this.categories);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<prod_provider.ProductList>(context);
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height*0.6,
      child: products.isEmpty
          ? const Center(
        child: Text('No products for the selected category!'),
      )
          : ListView.builder(
          itemBuilder: (ctx, index) => ProductItem(
              products[index], () {},
                  () {}),
          itemCount: products.length),
    );
  }
}
