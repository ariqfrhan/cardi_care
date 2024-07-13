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
          .get(const GetOptions(source: Source.cache));

      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<int> countObat({UserModel? userModel}) async {
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

      final snapshot = await firestore
          .collection('obat')
          .where('userId', isEqualTo: userId)
          .get(const GetOptions(source: Source.cache));

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
          .get(const GetOptions(source: Source.cache));

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

  Future<DateTime?> getLastRecordDate(String subCollection,
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

      final snapshot = await firestore
          .collection('riwayat')
          .doc(userId)
          .collection(subCollection)
          .orderBy('date', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return DateTime.parse(snapshot.docs.first['date']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<DateTime?> getLastSelfCareDate({UserModel? userModel}) async {
    List<String> subCollections = [
      'riwayat-obat',
      'diet-rendah-garam',
      'pembatasan-cairan',
      'berat',
      'olahraga',
      'rokok-alkohol'
    ];

    DateTime? lastDate;

    for (String subCollection in subCollections) {
      DateTime? date =
          await getLastRecordDate(subCollection, userModel: userModel);
      if (date != null && (lastDate == null || date.isAfter(lastDate))) {
        lastDate = date;
      }
    }

    return lastDate;
  }

  Future<bool> checkDataFromYesterday(String subCollection,
      {UserModel? userModel}) async {
    DateTime? lastDate =
        await getLastRecordDate(subCollection, userModel: userModel);
    if (lastDate == null) return false;

    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    DateTime startOfYesterday =
        DateTime(yesterday.year, yesterday.month, yesterday.day);
    DateTime endOfYesterday = startOfYesterday.add(const Duration(days: 14));

    return lastDate.isAfter(startOfYesterday) &&
        lastDate.isBefore(endOfYesterday);
  }

  Future<bool> checkSelfCareFromYesterday({UserModel? userModel}) async {
    List<String> subCollections = [
      'riwayat-obat',
      'diet-rendah-garam',
      'pembatasan-cairan',
      'berat',
      'olahraga',
      'rokok-alkohol'
    ];

    for (String subCollection in subCollections) {
      bool hasRecord =
          await checkDataFromYesterday(subCollection, userModel: userModel);
      if (hasRecord) return true;
    }

    return false;
  }
}
