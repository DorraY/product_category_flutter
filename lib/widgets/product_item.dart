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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(product.image,
                    height: 250, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                  bottom: 20,
                  right: 10,
                  left: 10,
                  child: Container(
                    color: Colors.black54,
                    width: MediaQuery.of(context).size.width ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.2,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              product.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle( color: Colors.white),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        Row(
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
                        )
                      ],
                    ),
                  )),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MediaQuery.of(context).size.width>500 ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.schedule),
                    const SizedBox(width: 6),
                    Text(
                        "Expires in ${(DateFormat.yMMMd().format(product.expiryDate))}"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.face),
                    const SizedBox(width: 6),
                    Text(product.category!.title),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.monetization_on),
                    const SizedBox(width: 6),
                    Text(product.price.toString()),
                  ],
                )
              ],
            ) : Column(children: <Widget>[


              Row(
                children: <Widget>[
                  const Icon(Icons.face),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.1,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                          "${product.category!.title}",textAlign: TextAlign.left),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.monetization_on),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.05,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                          "${product.price}",textAlign: TextAlign.left),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.schedule),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                          "Expires in ${(DateFormat.yMMMd().format(product.expiryDate))}",textAlign: TextAlign.left),
                    ),
                  ),
                ],
              ),

            ] ,
            mainAxisAlignment: MainAxisAlignment.start,),
          ),
        ],
      ),
    );
    /*return Card(
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
        title: product.category!=null ? Row(children: [
          Text('${product.name} - '),
          Text('${product.category!.title}',style: TextStyle(fontWeight: FontWeight.bold))
        ],) :  Text('${product.name}'),

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
    );*/
  }
}
