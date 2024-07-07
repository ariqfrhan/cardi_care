import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cardi_care/model/user_model.dart';

class RecordService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> countRecords(String subCollection, Duration duration,
      {UserModel? userModel}) async {
    try {
      User? currentUser = _auth.currentUser;
      String? userId;

      if (userModel != null) {
        userId = userModel.uid;
      } else if (currentUser != null) {
        userId = currentUser.uid;
      } else {
        throw Exception('User not logged in');
      }

      DateTime now = DateTime.now();
      DateTime targetDate = now.subtract(duration);

      final snapshot = await firestore
          .collection('riwayat')
          .doc(userId)
          .collection(subCollection)
          .where('date', isGreaterThanOrEqualTo: targetDate.toIso8601String())
          .get();

      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<int> countObatRecordsInLastDay({UserModel? userModel}) async {
    return await countRecords('riwayat-obat', const Duration(days: 1),
        userModel: userModel);
  }

  Future<int> countDietRecordsInLastDay({UserModel? userModel}) async {
    return await countRecords('diet-rendah-garam', const Duration(days: 1),
        userModel: userModel);
  }

  Future<int> countCairanRecordsInLastDay({UserModel? userModel}) async {
    return await countRecords('pembatasan-cairan', const Duration(days: 1),
        userModel: userModel);
  }

  Future<int> countBeratRecordsInLastDay({UserModel? userModel}) async {
    return await countRecords('berat', const Duration(days: 1),
        userModel: userModel);
  }

  Future<int> countOlahragaRecordsInLastDay({UserModel? userModel}) async {
    return await countRecords('olahraga', const Duration(days: 1),
        userModel: userModel);
  }

  Future<int> countRokokRecordsInLastDay({UserModel? userModel}) async {
    return await countRecords('rokok-alkohol', const Duration(days: 1),
        userModel: userModel);
  }

  Future<int> countObatRecordsInLastWeek({UserModel? userModel}) async {
    return await countRecords('riwayat-obat', const Duration(days: 7),
        userModel: userModel);
  }

  Future<int> countDietRecordsInLastWeek({UserModel? userModel}) async {
    return await countRecords('diet-rendah-garam', const Duration(days: 7),
        userModel: userModel);
  }

  Future<int> countCairanRecordsInLastWeek({UserModel? userModel}) async {
    return await countRecords('pembatasan-cairan', const Duration(days: 7),
        userModel: userModel);
  }

  Future<int> countBeratRecordsInLastWeek({UserModel? userModel}) async {
    return await countRecords('berat', const Duration(days: 7),
        userModel: userModel);
  }

  Future<int> countOlahragaRecordsInLastWeek({UserModel? userModel}) async {
    return await countRecords('olahraga', const Duration(days: 7),
        userModel: userModel);
  }

  Future<int> countRokokRecordsInLastWeek({UserModel? userModel}) async {
    return await countRecords('rokok-alkohol', const Duration(days: 7),
        userModel: userModel);
  }

  Future<int> countObatRecordsInLastMonth({UserModel? userModel}) async {
    return await countRecords('riwayat-obat', const Duration(days: 30),
        userModel: userModel);
  }

  Future<int> countDietRecordsInLastMonth({UserModel? userModel}) async {
    return await countRecords('diet-rendah-garam', const Duration(days: 30),
        userModel: userModel);
  }

  Future<int> countCairanRecordsInLastMonth({UserModel? userModel}) async {
    return await countRecords('pembatasan-cairan', const Duration(days: 30),
        userModel: userModel);
  }

  Future<int> countBeratRecordsInLastMonth({UserModel? userModel}) async {
    return await countRecords('berat', const Duration(days: 30),
        userModel: userModel);
  }

  Future<int> countOlahragaRecordsInLastMonth({UserModel? userModel}) async {
    return await countRecords('olahraga', const Duration(days: 30),
        userModel: userModel);
  }

  Future<int> countRokokRecordsInLastMonth({UserModel? userModel}) async {
    return await countRecords('rokok-alkohol', const Duration(days: 30),
        userModel: userModel);
  }

  Future<bool> checkData(String subCollection, {UserModel? userModel}) async {
    try {
      User? currentUser = _auth.currentUser;
      String? userId;

      if (userModel != null) {
        userId = userModel.uid;
      } else if (currentUser != null) {
        userId = currentUser.uid;
      } else {
        throw Exception('User not logged in');
      }

      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));
      final snapshot = await firestore
          .collection('riwayat')
          .doc(userId)
          .collection(subCollection)
          .where('date', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
          .where('date', isLessThan: endOfDay.toIso8601String())
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> checkObatRecords({UserModel? userModel}) async {
    return await checkData('riwayat-obat', userModel: userModel);
  }

  Future<bool> checkDietRecords({UserModel? userModel}) async {
    return await checkData('diet-rendah-garam', userModel: userModel);
  }

  Future<bool> checkCairanRecords({UserModel? userModel}) async {
    return await checkData('pembatasan-cairan', userModel: userModel);
  }

  Future<bool> checkBeratRecords({UserModel? userModel}) async {
    return await checkData('berat', userModel: userModel);
  }

  Future<bool> checkOlahragaRecords({UserModel? userModel}) async {
    return await checkData('olahraga', userModel: userModel);
  }

  Future<bool> checkRokokRecords({UserModel? userModel}) async {
    return await checkData('rokok-alkohol', userModel: userModel);
  }
}
