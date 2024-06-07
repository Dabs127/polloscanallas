import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_service.dart';

// Supplies CRUD

Future<List> getSupplies() async {
  List supplies = [];
  CollectionReference collectionReferenceSupplies = db.collection('supplies');

  QuerySnapshot querySupplies = await collectionReferenceSupplies.get();

  for (var document in querySupplies.docs) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final supply = {
      "uid": document.id,
      "name": data['name'],
      "SKU": data['SKU'],
      "expense": data['expense'],
      "stock": data['stock'],
      "description": data['description'],
      "supplier": data['supplier'],
      "type": data['type'],
      "url": data['url']
    };
    supplies.add(supply);
  }

  return supplies;
}

Future<void> addSupplies(String name, int expense, String SKU, String description,String image, String supplier, {int stock = 0, String type = 'supplies'} ) async {
  await db.collection("supplies").add({
    "name": name,
    "expense": expense,
    "SKU": SKU,
    "description": description,
    "stock": stock,
    "supplier": supplier,
    "url": image,
    "type": type
  });
}

Future<void> updateSupplies(String uid, String newName, int newExpense, String newSKU, String newDescription, String newImage, String newSupplier) async {
  await db.collection("supplies").doc(uid).update({
    "name": newName,
    "expense": newExpense,
    "SKU": newSKU,
    "description": newDescription,
    "supplier": newSupplier,
    "url": newImage
  });
}