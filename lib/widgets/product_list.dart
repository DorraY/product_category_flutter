import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';
import 'package:product_category/widgets/product_item.dart';


class ProductList extends StatelessWidget {


  final List<Product> products;
  final List<Category> categories;
  final Function deleteProduct;
  final Function editProductModalSheet;


  ProductList(this.products,this.categories, this.deleteProduct, this.editProductModalSheet);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height,
      child: products.isEmpty
          ? const Center(
        child: Text('No products just yet!\n Try adding some categories before adding products.'),
      )
          : ListView.builder(
          itemBuilder: (ctx, index) => ProductItem(
              products[index], deleteProduct,
              editProductModalSheet),
          itemCount: products.length),
    );
  }
}
