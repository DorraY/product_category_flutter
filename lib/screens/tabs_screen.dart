import 'dart:math';

import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';
import 'package:product_category/services/category_service.dart';
import 'package:product_category/widgets/product_form.dart';
import 'package:product_category/widgets/category_form.dart';

import 'category_screen.dart';
import 'product_screen.dart';

class TabsScreen extends StatefulWidget {

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  final CategoryService categoryService = CategoryService();
  List<Category> _categories=[] ;
  final List<Product> _products = [];

  int _selectedPageIndex =0 ;

  @override
  void initState() {
    categoryService.getCategories().then((categories) =>
        _categories = categories

    );
    categoryService.addCategory("titre").then((category) =>
      print(category)
    );
    super.initState();
  }

  Category getCategoryById(String id) {
    return _categories.firstWhere((category) => category.id == id);
  }

  void _editCategory(String id, String newTitle) {
    Category categoryToEdit = getCategoryById(id);
    setState(() {
      categoryToEdit.title = newTitle;
    });
  }

  void _deleteCategory(String id) {
    setState(() {
      _categories.removeWhere((category) => category.id == id);
    });
  }

  void _startEditCategory(BuildContext context, String id) {
    Category categoryToEdit = getCategoryById(id);
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return CategoryForm(_editCategory, true, id, categoryToEdit);
      },
    );
  }

  void _addNewCategory(String title) {
    final randomInteger = Random().nextInt(100) + _categories.length;
    final newCategory = Category(
        'C' + randomInteger.toString(), title);
    setState(() {
      _categories.add(newCategory);
    });
  }

  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  void _editProduct(String id, String newName, double newPrice, DateTime newDate, Category newCategory) {
    Product productToEdit = getProductById(id);
    setState(() {
      productToEdit.name = newName;
      productToEdit.price = newPrice;
      productToEdit.expiryDate = newDate;
      productToEdit.category = newCategory;
    });
  }

  void _deleteProduct(String id) {
    setState(() {
      _products.removeWhere((product) => product.id == id);
    });
  }

  void _startEditProduct(BuildContext context, String id) {
    Product productToEdit = getProductById(id);
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ProductForm(_editProduct, true, id, productToEdit,_categories);
      },
    );
  }

  void _addNewProduct(String name,double price, DateTime expiryDate, Category category) {
    final randomInteger = Random().nextInt(100) + _products.length;
    final newProduct = Product(
        'C' + randomInteger.toString(),name,price, expiryDate,category);
    setState(() {
      _products.add(newProduct);
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _openAddForm(BuildContext context, int pageIndex) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return pageIndex==0 ?  ProductForm(_addNewProduct,false,null,null,_categories) : CategoryForm(_addNewCategory,false,null,null);
      },
    );


  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String,dynamic>> _pages = [
      {'screen':ProductScreen(_products,_categories  ,_startEditProduct,_deleteProduct),'title':'Product'},
      {'screen':CategoryScreen(_categories,_startEditCategory,_deleteCategory),'title':'Category'},
    ] ;

    return Scaffold(
        appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title']),
        ),
        body: _pages[_selectedPageIndex]['screen'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items:  [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.category),
                label: 'Product List'
            ),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.star),
                label: 'Category List'
            ),
          ],
        ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () =>  {
              _openAddForm(context, _selectedPageIndex)
            }   ),
      ),

    );
  }
}
