import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';

class CategoryForm extends StatefulWidget {
  final Function action;
  final bool editMode;
  String? id;
  Category? categoryToEdit;

  CategoryForm(this.action, this.editMode, this.id, this.categoryToEdit);

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _titleController = TextEditingController();
  final _form = GlobalKey<FormState>();

  void patchTextFieldValues() {
    if (widget.editMode && widget.categoryToEdit != null) {
      _titleController.text = widget.categoryToEdit!.title;
    }
  }

  void _submitCategoryData(bool editMode) {
    final enteredTitle = _titleController.text;
    if (editMode) {
      widget.action(widget.id, enteredTitle);
    } else {
      widget.action(enteredTitle);
    }
    Navigator.of(context).pop();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      _form.currentState?.save();
      _submitCategoryData(widget.editMode);
    }
  }

  @override
  void initState() {
    patchTextFieldValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                            if (value!=null) {
                              if (value.isEmpty) {return 'Please enter the category title';}
                            }
                            return null;
                          } ,
                            cursorColor: Colors.purple,
                            decoration:  InputDecoration(
                              errorStyle: TextStyle(color: Theme.of(context).errorColor),
                              labelText: 'Title',
                              labelStyle: const TextStyle(color: Colors.purple),
                            ),
                            controller: _titleController,
                            onFieldSubmitted: (_) =>
                                _submitCategoryData(widget.editMode)),
                        Container(
                          height: MediaQuery.of(context).size.height*0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () => _saveForm(),
                                  child: Text(
                                      widget.editMode
                                          ? 'Edit category'
                                          : 'Add new category',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColorLight))),
                            ),
                          ],
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
