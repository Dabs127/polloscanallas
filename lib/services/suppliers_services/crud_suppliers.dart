import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_service.dart';

Future<List> getSuppliers() async {
  List suppliers = [];
  CollectionReference collectionReferenceSuppliers = db.collection('suppliers');

  QuerySnapshot querySuppliers = await collectionReferenceSuppliers.get();

  for (var document in querySuppliers.docs) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final supply = {
      "uid": document.id,
      "name": data['name'],
      "phonenumber": data['phonenumber'],
      "location": data['location'],
      "description": data['description'],
      "url": data['url'],
      "type": data['type']
    };
    suppliers.add(supply);
  }

  return suppliers;
}

Future<void> addSuppliers(String name, String phonenumber, String description, String image, String location, {String type = "suppliers"}) async {
  await db.collection("suppliers").add({
    "name": name,
    "phonenumber": phonenumber,
    "location": location,
    "description": description,
    "url": image,
    "type": type
  });
}

Future<void> updateSuppliers(String uid, String newName, String newPhoneNumber, String newLocation, String newDescription, String newImage) async {
  await db.collection("suppliers").doc(uid).update({
    "name": newName,
    "phonenumber": newPhoneNumber,
    "location": newLocation,
    "description": newDescription,
    "url": newImage
  });
}
