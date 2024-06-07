import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_service.dart';


// Products CRUD

Future<List> getProducts() async {
  List products = [];
  CollectionReference collectionReferenceProducts = db.collection('products');

  QuerySnapshot queryProducts = await collectionReferenceProducts.get();

  for (var document in queryProducts.docs) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final product = {
      "uid": document.id,
      "name": data['name'],
      "SKU": data['SKU'],
      "price": data['price'],
      "stock": data['stock'],
      "description": data['description'],
      "url": data['url'],
      "type": data['type']
    };
    products.add(product);
  }

  return products;
}

Future<void> addProducts(String name, int price, String SKU, String description,String image, {int stock = 0, String type = "products"} ) async {
  await db.collection("products").add({
    "name": name,
    "price": price,
    "SKU": SKU,
    "description": description,
    "stock": stock,
    "url": image,
    "type": type
  });
}

Future<void> updateProducts(String uid, String newname, int newprice, String newSKU, String newDescription, String newImage) async {
  await db.collection("products").doc(uid).update({
    "name": newname,
    "price": newprice,
    "SKU": newSKU,
    "description": newDescription,
    "url": newImage
  });
}