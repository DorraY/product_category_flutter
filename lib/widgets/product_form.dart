import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductForm extends StatefulWidget {
  final Function action;
  final bool editMode;
  String? id;
  Product? productToEdit;

  List<Category> categories;

  ProductForm(
      this.action, this.editMode, this.id, this.productToEdit, this.categories);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  late DateTime _selectedDate;
  late String selectedDropdownValue;



  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = widget.categories
        .map((category) =>
            DropdownMenuItem(child: Text(category.title), value: category.id))
        .toList();
    return menuItems;
  }

  void patchTextFieldValues() {
    selectedDropdownValue = widget.categories.first.id;
    if (widget.editMode && widget.productToEdit != null) {
      _nameController.text = widget.productToEdit!.name;
      _priceController.text = widget.productToEdit!.price.toString();
      _selectedDate = widget.productToEdit!.expiryDate;
      selectedDropdownValue = widget.productToEdit!.category!.id;
    } else {
      _selectedDate = DateTime.now() ;
    }
  }

  void _submitProductData(bool editMode) {
    final enteredName = _nameController.text;
    final enteredPrice = null ?? double.tryParse(_priceController.text);
    final categoryId = selectedDropdownValue;

    if (enteredPrice == null ||
        enteredName.isEmpty ||
        enteredPrice <= 0 ||
        _selectedDate == null ||
        categoryId == null) {
      return;
    }
    final requestedCategory =
        widget.categories.firstWhere((category) => category.id == categoryId);

    if (editMode) {
      widget.action(widget.productToEdit!.id, enteredName, enteredPrice,
          _selectedDate, requestedCategory);
    } else {
      widget.action(
          enteredName, enteredPrice, _selectedDate, requestedCategory);
    }
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    DateTime currentDate = DateTime.now();

    DateTime firstDate = DateTime(currentDate.year -5, currentDate.month , currentDate.day);
    DateTime lastDate = DateTime(currentDate.year+5, currentDate.month , currentDate.day);

    showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: firstDate,
            lastDate: lastDate)
        .then((pickedDate) {
      if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }

    });
  }

  @override
  void initState() {
    patchTextFieldValues();
    var initialDropDownItem = dropdownItems.firstWhere(
            (dropDownElement) => dropDownElement.value == selectedDropdownValue);
    selectedDropdownValue = initialDropDownItem.value!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                    cursorColor: Colors.purple,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                    controller: _nameController),
                TextFormField(
                    cursorColor: Colors.purple,
                    decoration: const InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(color: Colors.purple)),
                    controller: _priceController,
                    keyboardType: TextInputType.number),
                DropdownButtonFormField(
                  items: dropdownItems,
                  value: selectedDropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDropdownValue = newValue!;
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(),
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.editMode ?  (DateFormat.yMMMd().format(_selectedDate))  : (_selectedDate == null
                            ? 'No Date Chosen'
                            : DateFormat.yMMMd().format(_selectedDate))

                      ),
                      TextButton(
                          onPressed: _presentDatePicker,
                          child: Text('Choose Expiry Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).primaryColor)))
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                ElevatedButton(
                    onPressed: () => _submitProductData(widget.editMode),
                    child: Text(
                        widget.editMode ? 'Edit product' : 'Add new product',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)))
              ],
            ),
          )),
    );
  }
}
