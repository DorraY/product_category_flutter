import 'package:product_category/models/category.dart';
import 'package:product_category/models/product.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'image_picker_widget.dart';

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
  final _form = GlobalKey<FormState>();


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
      selectedDropdownValue = widget.productToEdit!.category.id;
    } else {
      _selectedDate = DateTime.now();
    }
  }

  void _submitProductData(bool editMode) {
    final enteredName = _nameController.text;
    final enteredPrice = null ?? double.tryParse(_priceController.text);
    final categoryId = selectedDropdownValue;

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

    DateTime firstDate =
        DateTime(currentDate.year - 5, currentDate.month, currentDate.day);
    DateTime lastDate =
        DateTime(currentDate.year + 5, currentDate.month, currentDate.day);

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
  
  Widget DatePickerWidget() {
    return TextButton(
        onPressed: _presentDatePicker,
        child: Text('Choose Expiry Date',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor)));
  }

  Widget DateDisplayWidget() {
    return Text(
      widget.editMode
          ? (DateFormat.yMMMd().format(_selectedDate))
          : (_selectedDate == null
          ? 'No Date Chosen'
          : DateFormat.yMMMd()
          .format(_selectedDate)),
      textAlign: TextAlign.center,
    );
  }

  Widget SubmitButtonWidget() {
    return ElevatedButton(
        onPressed: () => _saveForm(),
        child: Text(
            widget.editMode
                ? 'Edit product'
                : 'Add new product',
            style: TextStyle(
                color: Theme.of(context).primaryColorLight)));
  }

  _saveForm() {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      _form.currentState?.save();
      _submitProductData(widget.editMode);
    }


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
    print(MediaQuery.of(context).size.width);
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            height: MediaQuery.of(context).size.height*0.5,
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Form(
                  key: _form,
                  child: Expanded(
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                            validator: (value) {
                              if (value?.length==0) {return 'Please provide a name for the product';}
                              return null;
                            },
                            cursorColor: Colors.purple,
                            decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: const TextStyle(color: Colors.purple),
                                errorStyle: TextStyle(color: Theme.of(context).errorColor)
                            ),
                            controller: _nameController),
                        TextFormField(
                            validator: (value) {
                              if (value?.length==0) {return 'Please provide a price for the product';}
                              if (double.tryParse(value!) == null) {return 'Please a valid number';}
                              if (double.tryParse(value)! <= 0) {return 'Please a valid number greater than 0';}
                              return null;
                            },
                            cursorColor: Colors.purple,
                            decoration:  InputDecoration(
                                errorStyle: TextStyle(color: Theme.of(context).errorColor),
                                labelText: 'Price',
                                labelStyle: const TextStyle(color: Colors.purple)),
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
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: MediaQuery.of(context).size.width > 300
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              DateDisplayWidget(),
                              DatePickerWidget()
                            ],
                          )
                              : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height:
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                DateDisplayWidget(),
                                DatePickerWidget()
                              ]),
                        ),
                        MediaQuery.of(context).size.width > 300
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            ImagePickerWidget(),
                          ],
                        )
                            : Container(),
                        MediaQuery.of(context).size.width > 300
                            ? SizedBox(
                          width: 100,
                              child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                              SubmitButtonWidget()
                          ],
                        ),
                            )
                            : Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ImagePickerWidget(),
                              Container(height: MediaQuery.of(context).size.height*0.04,),
                              SubmitButtonWidget(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          )),
    );
  }




}
