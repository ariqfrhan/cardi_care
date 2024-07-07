import 'package:cardi_care/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class KeluargaServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserCredential? userCredential;

  Future<List<UserModel>> getUsersByKeluargaId(String familyId) async {
    QuerySnapshot snapshot = await firestore
        .collection('users')
        .where('familyId', isEqualTo: familyId)
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<UserModel>> searchUsersUnderKeluarga(
      String familyId, String name) async {
    QuerySnapshot snapshot = await firestore
        .collection("users")
        .where('familyId', isEqualTo: familyId)
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThanOrEqualTo: '$name\uf8ff')
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
