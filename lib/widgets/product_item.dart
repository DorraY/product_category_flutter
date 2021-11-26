import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_category/models/product.dart';



class ProductItem extends StatelessWidget {

  final Product product;
  final Function deleteProduct;
  final Function editProductModalSheet;


  ProductItem(this.product, this.deleteProduct, this.editProductModalSheet);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
                child: Text(
                  '\$${product.price}',
                  style: const TextStyle(color: Colors.white),
                )),
          ),
        ),
        title:  product.category!=null ?  Text('${product.name} - ${product!.category!.title}') : Text('${product.name}'),
        subtitle: Text('Expires in ${DateFormat.yMMMd().format(product.expiryDate)}'),
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: MediaQuery.of(context).size.width > 550
              ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                  label: const Text('Delete'),
                  onPressed: () => deleteProduct(product.id),
                  icon: const Icon(Icons.delete)),
              TextButton.icon(
                  label: const Text('Edit'),
                  onPressed: () =>
                      editProductModalSheet(context, product.id),
                  icon: const Icon(Icons.auto_fix_high))
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => deleteProduct(product.id),
                  icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () =>
                      editProductModalSheet(context, product.id),
                  icon: const Icon(Icons.auto_fix_high))
            ],
          ),
        ),
      ),
    );
  }
}
