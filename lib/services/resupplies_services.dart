import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

Future<List> getResupplies() async {
  List resupplies = [];
  CollectionReference collectionReferenceProducts = db.collection('resupplies');

  QuerySnapshot queryResupplies = await collectionReferenceProducts.get();

  for (var document in queryResupplies.docs) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final resupply = {
      "uid": document.id,
      "branch": data['branch'],
      "date": data['date'],
      "total": data['total'],
      "arrayorders": data['arrayorders'],
      "type": data['type']
    };
    resupplies.add(resupply);
  }

  resupplies.sort((a, b) => b['date'].compareTo(a['date']));

  return resupplies;
}

Future<void> addResupplies(String branch, Timestamp date, int total, List<Map<String, dynamic>> arrayOrders, {String type = "resupplies"}) async {
  await db.collection("resupplies").add({
    "branch": branch,
    "date": date,
    "total": total,
    "arrayorders": arrayOrders,
    "type": type
  });
}