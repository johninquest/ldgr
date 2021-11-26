import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  getCurrentUser() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    print(firebaseUser);
  }
}
