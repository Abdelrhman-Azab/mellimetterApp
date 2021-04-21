import 'package:flutter/material.dart';
import 'package:mellimeter/widgets/productItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/product.dart';

class FurnitureProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Center(child: CircularProgressIndicator());
        List<Product> products = [];
        for (int i = 0; i < snapshot.data.docs.length; i++) {
          var myData = snapshot.data.docs[i];
          if (myData["category"] == "furniture")
            products.add(
              Product(
                title: myData["title"],
                price: myData["price"],
                category: myData["category"],
                id: myData["id"],
                descreption: myData["descreption"],
                imageurl: myData["imageurl"],
              ),
            );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return ProductItem(
                products[index].id,
                products[index].imageurl,
                products[index].title,
                products[index].price,
                products[index].descreption,
                products[index].category);
          },
          itemCount: products.length,
        );
      },
    );
  }
}
