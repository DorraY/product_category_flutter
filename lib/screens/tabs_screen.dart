import 'dart:math';

import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';
import 'package:product_category/models/product_list.dart';
import 'package:product_category/services/category_service.dart';
import 'package:product_category/services/product_service.dart';
import 'package:product_category/widgets/product_form.dart';
import 'package:product_category/widgets/category_form.dart';
import 'package:provider/provider.dart';

import 'category_screen.dart';
import 'product_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final CategoryService categoryService = CategoryService();
  List<Category> _categories = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    categoryService
        .getCategories()
        .then((categories) => _categories = categories);
    super.initState();
  }

  Category getCategoryById(String id) {
    return _categories.firstWhere((category) => category.id == id);
  }

  void _editCategory(String id, String newTitle) async {
    Category categoryToEdit = getCategoryById(id);
    await categoryService.updateCategory(id, newTitle);
    setState(() {
      categoryToEdit.title = newTitle;
    });
  }

  void _deleteCategory(String id) async {
    await categoryService.deleteCategory(id);
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

  void _addNewCategory(String title) async {
    Category newCategory = await categoryService.addCategory(title);
    setState(() {
      _categories.add(newCategory);
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _openAddForm(
      BuildContext context, int pageIndex, ProductList productList) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return pageIndex == 1
            ? (_categories.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child:  Center(
                      child: Text(
                        'You cannot add a product without adding categories first',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: MediaQuery.of(context).size.width*0.03),
                      ),
                    ))
                : ProductForm(
                    productList.addProduct, false, null, null, _categories))
            : (CategoryForm(_addNewCategory, false, null, null));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductList>(context,listen: false);

    final List<Map<String, dynamic>> _pages = [
      {
        'screen':
            CategoryScreen(_categories, _startEditCategory, _deleteCategory),
        'title': 'Category'
      },
      {'screen': ProductScreen(_categories), 'title': 'Product'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.star),
              label: 'Category List'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.category),
              label: 'Product List'),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
            tooltip: _selectedPageIndex == 1
                ? 'Add new product'
                : 'Add new category',
            child: const Icon(Icons.add),
            onPressed: () =>
                {_openAddForm(context, _selectedPageIndex, productProvider)}),
      ),
    );
  }
}
