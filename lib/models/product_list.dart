import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:product_category/services/category_service.dart';
import 'package:product_category/services/product_service.dart';
import 'package:product_category/widgets/product_form.dart';
import 'category.dart' as cat;
import 'product.dart';

class ProductList extends ChangeNotifier {
  List<Product> _products = [];
  bool showProductList = false;
  ProductService productService = ProductService();

  void getProductsByCategory(String id) {
    productService.getProducts(id).then((productsFromDB)
    {
      _products = productsFromDB ;
      if (_products.isNotEmpty) {
        showProductList = true;
      } else {
        showProductList = false;
      }
      notifyListeners();
    }) ;
  }

  List<Product> get products {
    return [..._products];
  }

  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  void addProduct(String newName,double newPrice, DateTime newExpiryDate, cat.Category newCategory) async{
    Product newProduct = await productService.addProduct(newName,newPrice,newExpiryDate,newCategory);
    _products.add(newProduct);
    notifyListeners();
  }

  void deleteProduct(String productId) async {
    await productService.deleteProduct(productId);
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  void startEditProduct(BuildContext context, String id) {
    Product productToEdit = getProductById(id);
    List<cat.Category> _categories = [];
    final CategoryService categoryService = CategoryService();

    categoryService.getCategories().then((categories) {
      _categories = categories;
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return ProductForm(editProduct, true, id, productToEdit,_categories);
        },
      );
    }
    );
  }

  void editProduct(String id, String newName, double newPrice, DateTime newDate, cat.Category newCategory) async{
    Product productToEdit = getProductById(id);
    await productService.updateProduct(id, newName,newPrice,newDate,newCategory);
    productToEdit.name = newName;
    productToEdit.price = newPrice;
    productToEdit.expiryDate = newDate;
    productToEdit.category = newCategory;
    notifyListeners();
  }
}