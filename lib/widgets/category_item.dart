import 'package:flutter/material.dart';
import 'package:product_category/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category ;
  final Function deleteCategory;
  final Function editCategoryModalSheet;

  CategoryItem(this.category, this.deleteCategory, this.editCategoryModalSheet);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        title: Text(category.title),
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: MediaQuery.of(context).size.width  > 550
              ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                  label: const Text('Delete'),
                  onPressed: () => deleteCategory(
                      category.id),
                  icon: const Icon(Icons.delete)),
              TextButton.icon(
                  label: const Text('Edit'),
                  onPressed: () =>
                      editCategoryModalSheet(
                          context, category.id),
                  icon: const Icon(Icons.auto_fix_high))
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => deleteCategory(
                      category.id),
                  icon: const  Icon(Icons.delete)),
              IconButton(
                  onPressed: () =>
                      editCategoryModalSheet(
                          context, category.id),
                  icon: const Icon(Icons.auto_fix_high))
            ],
          ),
        ),
      ),
    );

      ;
  }
}
