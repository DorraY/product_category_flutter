import 'package:product_category/models/product.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ProductForm extends StatefulWidget {
  final Function action;
  final bool editMode;
  String? id;
  Product? productToEdit;

  ProductForm(this.action, this.editMode, this.id, this.productToEdit);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  late final  categoryValue ;

  DateTime? _selectedDate;
  DateTime? _editedDate;


  void patchTextFieldValues() {
    if (widget.editMode && widget.productToEdit != null) {
      _nameController.text = widget.productToEdit!.name;
      _priceController.text = widget.productToEdit!.name.toString();
      _selectedDate = widget.productToEdit!.expiryDate;
      categoryValue = widget.productToEdit!.category;
    }
  }

  void _submitProductData(bool editMode) {
    final enteredName = _nameController.text;
    final enteredPrice = null ?? double.tryParse(_priceController.text);
    final enteredCategory = categoryValue;

    if (enteredPrice == null ||
        enteredName.isEmpty ||
        enteredCategory.isEmpty ||
        enteredPrice <= 0 ||
        _selectedDate == null) {
      return;
    }

    if (editMode) {
      widget.action(widget.id, enteredName, enteredPrice, enteredCategory,
          _selectedDate, enteredCategory);
    } else {
      widget.action(enteredName, enteredPrice, enteredCategory, _selectedDate,
          enteredCategory);
    }
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, 11, 1),
        lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        _selectedDate = pickedDate;
      } else {
        setState(() {
          if (widget.editMode) {_editedDate=pickedDate;
          }
          else {_selectedDate = pickedDate;}
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    patchTextFieldValues();
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            height: MediaQuery.of(context).size.height*0.6,
            padding: EdgeInsets.only(
                top:10,
                left:10,
                right:10,
                bottom: MediaQuery.of(context).viewInsets.bottom+10 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                    controller: _nameController,
                    onFieldSubmitted: (_) =>
                        _submitProductData(widget.editMode)),
                TextFormField(
                    cursorColor: Colors.purple,
                    decoration: const InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(color: Colors.purple)),
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_) =>
                        _submitProductData(widget.editMode)),
                Container(
                  padding: const EdgeInsets.symmetric(),
                  height: MediaQuery.of(context).size.height*0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_selectedDate == null
                          ? 'No Date Chosen'
                          : DateFormat.yMMMd().format(_selectedDate!)),
                      TextButton(
                          onPressed: _presentDatePicker,
                          child: Text('Choose Expiry Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).primaryColor)))
                    ],
                  ),
                ),
                DropdownButtonFormField(
                value: 'Dorra',
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Theme.of(context).primaryColor),
                onChanged: (String? newValue) {
                  setState(() {
                    categoryValue = newValue!;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
                ElevatedButton(
                    onPressed: () => _submitProductData(widget.editMode),
                    child: Text(
                        widget.editMode
                            ? 'Edit product'
                            : 'Add new product',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)))
              ],
            ),
          )),
    );
  }
}
