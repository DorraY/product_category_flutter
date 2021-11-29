import 'package:flutter/cupertino.dart';
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
    return Column(
      children: [
        Card(
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
                                  color: Colors.white,
                                    onPressed: () => deleteProduct(product.id),
                                    icon: const Icon(Icons.delete)),
                                IconButton(
                                    color: Colors.white,
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
                child: MediaQuery.of(context).size.width>300 ? Row(
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
                      const Icon(Icons.schedule),
                      const SizedBox(width: 6),
                      Text(
                          "${(DateFormat.yMd().format(product.expiryDate))}",textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.face),
                      const SizedBox(width: 6),
                      Text(
                          "${product.category!.title}",textAlign: TextAlign.left),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.monetization_on),
                      const SizedBox(width: 6),
                      Text(
                          "${product.price}",textAlign: TextAlign.left),
                    ],
                  ),
                ] ,
                mainAxisAlignment: MainAxisAlignment.start,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
