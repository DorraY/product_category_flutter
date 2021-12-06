import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';
import 'package:product_category/services/product_service.dart';
import 'package:product_category/widgets/product_list.dart';
import '../models/product_list.dart' as prod_provider;
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final List<Category> categories;

  ProductScreen(this.categories);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String? selectedDropDownValue;
  final ProductService productService = ProductService();
  List<Product> products = [];
  bool showProductList = false;

  @override
  void initState() {
    selectedDropDownValue =
        widget.categories.isNotEmpty ? widget.categories.first.id : '';
    super.initState();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    if (widget.categories.isNotEmpty) {
      List<DropdownMenuItem<String>> menuItems = widget.categories
          .map((category) =>
              DropdownMenuItem(child: Text(category.title), value: category.id))
          .toList();
      return menuItems;
    } else {
      return [];
    }
  }

  getProductsByCategory(String id) {
    productService.getProducts(id).then((productsFromDB) {
      products = productsFromDB;
      setState(() {
        if (products.isNotEmpty) {
          showProductList = true;
        } else {
          showProductList = false;
        }
      });
    });
  }

  Widget categoriesDropDown(double size) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * size,
      child: DropdownButtonFormField(
        items: dropdownItems,
        value: selectedDropDownValue,
        onChanged: (String? newValue) {
          setState(() {
            selectedDropDownValue = newValue!;
          });
        },
      ),
    );
  }

  Widget getDataButton(double size, prod_provider.ProductList productProvider) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width * size,
        child: ElevatedButton(
            onPressed: () =>
                productProvider.getProductsByCategory(selectedDropDownValue!),
            child: const Text('Fetch products')));
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<prod_provider.ProductList>(context);

    return widget.categories.isNotEmpty
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MediaQuery.of(context).size.width > 500
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            categoriesDropDown(0.5),
                            getDataButton(0.3, productProvider)
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            categoriesDropDown(1),
                            Container(
                              height: 10,
                            ),
                            getDataButton(0.5, productProvider)
                          ],
                        ),
                  ProductList(productProvider.products, widget.categories)
                ],
              ),
            ),
          )
        : const Center(child: Text('You need categories to view the products'));
  }
}
