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

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<prod_provider.ProductList>(context,listen: false);
    productProvider.selectedCategory = (widget.categories.isNotEmpty ?  selectedDropDownValue :  '')!;

    return widget.categories.isNotEmpty
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  categoriesDropDown(1),
                  ProductList()
                ],
              ),
            ),
          )
        :  Center(child: Text('You need categories to view the products',style:
      TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)
      ,));
  }
}
