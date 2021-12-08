import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore fsInstance = FirebaseFirestore.instance;

  getCollection(String collectionName) async {
    CollectionReference _collection = fsInstance.collection(collectionName);
    try {
      QuerySnapshot snapshot =
          await _collection.orderBy('created_at', descending: true).get();
      List<dynamic> fsReponse = snapshot.docs.map((doc) => doc.data()).toList();
      return fsReponse;
    } catch (e) {
      return null;
    }
  }

  getSubCollection() async {
    CollectionReference _collection = fsInstance
        .collection('the_wine_reserve')
        .doc('records')
        .collection('daybook');
    try {
      QuerySnapshot snapshot =
          await _collection.orderBy('picked_date', descending: true).get();
      List<dynamic> fsReponse = snapshot.docs.map((doc) => doc.data()).toList();
      return fsReponse;
    } catch (e) {
      return null;
    }
  }

  getDocument(String colName, String docName) async {
    DocumentSnapshot _doc =
        await FirebaseFirestore.instance.collection(colName).doc(docName).get();
    return _doc;
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

  addDocumentWithId(String _id, Map<String, dynamic> _data) async {
    var targetCollection = fsInstance
        .collection('the_wine_reserve')
        .doc('records')
        .collection('daybook');
    try {
      await targetCollection.doc(_id).set(_data);
      return 'add-success';
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return 'permission-denied';
      }
    }
  }

  getDocumentWithId(String _id) async {
    var targetDoc = fsInstance
        .collection('the_wine_reserve')
        .doc('users')
        .collection('user_list')
        .doc(_id);
    try {
      var getResponse = await targetDoc.get();
      return getResponse;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  removeDocument(String _docId) async {
    CollectionReference _col = fsInstance
        .collection('the_wine_reserve')
        .doc('records')
        .collection('daybook');
    try {
      var delResponse = await _col.doc(_docId).delete();
      return delResponse;
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  updateDocument(String _docId, Map<String, Object?> _docData) async {
    CollectionReference _col = fsInstance
        .collection('the_wine_reserve')
        .doc('records')
        .collection('daybook');
    try {
      var updateResponse = await _col.doc(_docId).update({
        'picked_date':  _docData[''],
        'cost_area': _docData[''], 
        'item_category': _docData[''], 
        'item_name': _docData[''],  
        'quantity': _docData[''], 
        'unit': _docData[''], 
        'price': _docData[''],
        'payment_status': _docData[''], 
        'payment_method': _docData[''], 
        'last_update_at': _docData[''], 
        'entered_by': _docData[''], 
      });
      return updateResponse;
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }
}
