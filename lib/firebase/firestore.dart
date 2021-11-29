import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore fsInstance = FirebaseFirestore.instance;
  CollectionReference appData = FirebaseFirestore.instance.collection('ldgr');

/*   getData() async {
    QuerySnapshot _collection = await appData.get();
    DocumentSnapshot _doc = await appData.doc('areas').get();
    var _showData = _doc['accounting'];
    print(_showData[0]);
    print('Firestore collection => $_collection');
    print('Firestore document(s) => $_doc');
    /* print(_doc['name'] ?? ''); 
    print(_doc['age'] ?? '');
    print(_doc['country']); */
  } */

  getDocumentData(String docName) async {
    DocumentSnapshot _doc = await appData.doc('areas').get();
    var _docData = _doc[docName];
    return _docData;
  }

  saveDoc(Map<String, dynamic> _data) async {
    await fsInstance.collection('daybook').add(_data).then((value) {
      print('Firestore response => $value');
    });
  }
}
