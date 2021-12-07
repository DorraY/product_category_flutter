import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';
import 'package:product_category/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../models/product_list.dart' as prod_provider;


class ProductList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<prod_provider.ProductList>(context);
    final mediaQuery = MediaQuery.of(context);
    productProvider.getProductsByCategory(productProvider.selectedCategory);

    return SizedBox(
      height: mediaQuery.size.height*0.6,
      child: productProvider.products.isEmpty
          ?  Center(
        child: Text('No products for the selected category!',style: TextStyle(
          fontSize: MediaQuery.of(context).size.width*0.03
        ),),
      )
          : ListView.builder(
          itemBuilder: (ctx, index) => ProductItem(
              productProvider.products[index], productProvider.deleteProduct,
                  productProvider.startEditProduct),
          itemCount: productProvider.products.length),
    );
  }
}
