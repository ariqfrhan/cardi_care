import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/services/record_service.dart';
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

  Future<List<Map<String, dynamic>>> fetchUsersWithoutSelfCare() async {
    List<UserModel> users = await getAllUsers();

    List<Future<Map<String, dynamic>>> futures = users.map((user) async {
      bool hasSelfCare =
          await RecordService().checkSelfCareFromYesterday(userModel: user);
      if (!hasSelfCare) {
        DateTime? lastDate =
            await RecordService().getLastSelfCareDate(userModel: user);
        int? daysSinceLastSelfCare = lastDate != null
            ? DateTime.now().difference(lastDate).inDays
            : null;
        return {'user': user, 'daysSinceLastSelfCare': daysSinceLastSelfCare};
      }
      return {'user': user, 'daysSinceLastSelfCare': 0};
    }).toList();

    List<Map<String, dynamic>> usersWithoutSelfCare =
        await Future.wait(futures);

    // Filter pengguna yang tidak melakukan self-care
    return usersWithoutSelfCare
        .where((entry) => entry['daysSinceLastSelfCare'] != 0)
        .toList();
  }
}
