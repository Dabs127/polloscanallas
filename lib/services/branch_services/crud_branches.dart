import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_service.dart';

Future<List> getBranches() async {
  List branches = [];
  CollectionReference collectionReferenceBranches = db.collection('branches');

  QuerySnapshot queryBranches = await collectionReferenceBranches.get();

  for (var document in queryBranches.docs) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final branch = {
      "uid": document.id,
      "name": data['name'],
      "location": data['location'],
      "phonenumber": data['phonenumber'],
      "description": data['description'],
      "url": data['url'],
      "type": data['type']
    };
    branches.add(branch);
  }

  return branches;
}

Future<void> addBranches(String name, String location, String phoneNumber, String description,String image, {String type = "branches"} ) async {
  await db.collection("branches").add({
    "name": name,
    "location": location,
    "phonenumber": phoneNumber,
    "description": description,
    "url": image,
    "type": type
  });
}

Future<void> updateBranches(String uid, String newName, String newLocation, String newPhoneNumber, String newDescription, String newImage) async {
  await db.collection("branches").doc(uid).update({
    "name": newName,
    "location": newLocation,
    "phonenumber": newPhoneNumber,
    "description": newDescription,
    "url": newImage
  });
}