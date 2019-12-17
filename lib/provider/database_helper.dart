import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;

Map<String, dynamic> getData() {
  databaseReference
      .collection("events")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach(((f) {
      return f.data;
    }));
  });
}
