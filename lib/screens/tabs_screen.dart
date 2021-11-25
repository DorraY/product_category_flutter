import 'dart:math';

import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';
import 'package:product_category/widgets/product_form.dart';
import 'package:product_category/widgets/category_form.dart';

import 'category_screen.dart';
import 'product_screen.dart';

class TabsScreen extends StatefulWidget {

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  final List<Category> _categories = [
     Category('C0', 'Categorie1'),
     Category('C1', 'Categorie2'),
     Category('C2', 'Categorie3'),
    Category('C3', 'Categorie4'),
    Category('C4', 'Categorie5'),
  ];

  final List<Product> _products = [
    Product('P0', 'Product0',12.777,DateTime.now(), Category('C4', 'Categorie5')),
    Product('P1', 'Product1',12.25,DateTime.now(), Category('C2', 'Categorie2')),
    Product('P2', 'Product2',12.7,DateTime.now(), Category('C3', 'Categorie3')),
    Product('P3', 'Product3',98.0,DateTime.now(), Category('C0', 'Categorie0')),
  ];

  int _selectedPageIndex =0 ;


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
        return pageIndex==0 ?  ProductForm(_addNewProduct,false,null,null) : CategoryForm(_addNewCategory,false,null,null);
      },
    );


  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String,dynamic>> _pages = [
      {'screen':ProductScreen(),'title':'Product'},
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
