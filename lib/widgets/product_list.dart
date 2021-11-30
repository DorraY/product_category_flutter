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
    print(mediaQuery.size.height);
    print(mediaQuery.size.width);

    return SizedBox(
      height: mediaQuery.size.height*0.6,
      child: products.isEmpty
          ? const Center(
        child: Text('No products for the selected category!'),
      )
          : ListView.builder(
          itemBuilder: (ctx, index) => ProductItem(
              products[index], deleteProduct,
              editProductModalSheet),
          itemCount: products.length),
    );
  }
}
