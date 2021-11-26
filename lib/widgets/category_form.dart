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

  void patchTextFieldValues() {
    if (widget.editMode && widget.categoryToEdit != null) {
      _titleController.text = widget.categoryToEdit!.title;
    }
  }

  void _submitCategoryData(bool editMode) {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty) {
      return;
    }
    if (editMode) {
      widget.action(
          widget.id, enteredTitle);
    } else {
      widget.action(enteredTitle);
    }
    Navigator.of(context).pop();
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
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                    controller: _titleController,
                    onFieldSubmitted: (_) =>
                        _submitCategoryData(widget.editMode)),
                Container(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                ElevatedButton(
                    onPressed: () => _submitCategoryData(widget.editMode),
                    child: Text(
                        widget.editMode
                            ? 'Edit category'
                            : 'Add new category',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)))
              ],
            ),
          )),
    );
  }
}
