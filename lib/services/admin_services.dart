import 'package:cardi_care/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserCredential? userCredential;

  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot snapshot = await firestore.collection('users').get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<UserModel>> searchAllUsers(String name) async {
    QuerySnapshot snapshot = await firestore
        .collection("users")
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThanOrEqualTo: '$name\uf8ff')
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
