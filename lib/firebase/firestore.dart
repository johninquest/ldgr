import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore fsInstance = FirebaseFirestore.instance;
  CollectionReference appData = FirebaseFirestore.instance.collection('ldgr');

  getDocument(String docName) async {
    DocumentSnapshot _doc = await appData.doc('areas').get();
    var _docData = _doc[docName];
    return _docData;
  }

  addDocument(Map<String, dynamic> _data) async {
    try {
      await fsInstance.collection('daybook').add(_data);
      return 'add-success';
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return 'permission-denied';
      }
    }
  }

  getCollection(String collectionName) async {
    CollectionReference _collection = fsInstance.collection(collectionName);
    try {
      QuerySnapshot snapshot = await _collection.get();
      List<dynamic> fsReponse = snapshot.docs.map((doc) => doc.data()).toList();
      return fsReponse;
    } catch (e) {
      // print('Error occured => $e');
      return null;
    }
  }
}
