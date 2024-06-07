import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> deleteDocument(String uid, String collection) async {
  await db.collection(collection).doc(uid).delete();
}

Future<void> addStock(String uid, String collectionString, int newStock) async {
  var document = FirebaseFirestore.instance.collection(collectionString).doc(uid);
  var docSnapshot = await document.get();

  final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

  int stock = data['stock'];
  newStock = stock + newStock;

  await document.update({
    'stock': newStock
  });

}
