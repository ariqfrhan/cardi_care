import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class RecordService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserCredential? userCredential;

  Future<int> countRecords(String collection, Duration duration) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      DateTime now = DateTime.now();
      DateTime targetDate = now.subtract(duration);

      final snapshot = await firestore
          .collection(collection)
          .where('userId', isEqualTo: user.uid)
          .where('date', isGreaterThanOrEqualTo: targetDate.toIso8601String())
          .get();

      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<int> countObatRecordsInLastDay() async {
    return await countRecords('riwayat-obat', const Duration(days: 1));
  }

  Future<int> countDietRecordsInLastDay() async {
    return await countRecords('diet-rendah-garam', const Duration(days: 1));
  }

  Future<int> countCairanRecordsInLastDay() async {
    return await countRecords('pembatasan-cairan', const Duration(days: 1));
  }

  Future<int> countBeratRecordsInLastDay() async {
    return await countRecords('berat', const Duration(days: 1));
  }

  Future<int> countOlahragaRecordsInLastDay() async {
    return await countRecords('olahraga', const Duration(days: 1));
  }

  Future<int> countRokokRecordsInLastDay() async {
    return await countRecords('rokok-alkohol', const Duration(days: 1));
  }

  Future<int> countObatRecordsInLastWeek() async {
    return await countRecords('riwayat-obat', const Duration(days: 7));
  }

  Future<int> countDietRecordsInLastWeek() async {
    return await countRecords('diet-rendah-garam', const Duration(days: 7));
  }

  Future<int> countCairanRecordsInLastWeek() async {
    return await countRecords('pembatasan-cairan', const Duration(days: 7));
  }

  Future<int> countBeratRecordsInLastWeek() async {
    return await countRecords('berat', const Duration(days: 7));
  }

  Future<int> countOlahragaRecordsInLastWeek() async {
    return await countRecords('olahraga', const Duration(days: 7));
  }

  Future<int> countRokokRecordsInLastWeek() async {
    return await countRecords('rokok-alkohol', const Duration(days: 7));
  }

  Future<int> countObatRecordsInLastMonth() async {
    return await countRecords('riwayat-obat', const Duration(days: 30));
  }

  Future<int> countDietRecordsInLastMonth() async {
    return await countRecords('diet-rendah-garam', const Duration(days: 30));
  }

  Future<int> countCairanRecordsInLastMonth() async {
    return await countRecords('pembatasan-cairan', const Duration(days: 30));
  }

  Future<int> countBeratRecordsInLastMonth() async {
    return await countRecords('berat', const Duration(days: 30));
  }

  Future<int> countOlahragaRecordsInLastMonth() async {
    return await countRecords('olahraga', const Duration(days: 30));
  }

  Future<int> countRokokRecordsInLastMonth() async {
    return await countRecords('rokok-alkohol', const Duration(days: 30));
  }

  Future<bool> checkData(String collections) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));
      final snapshot = await firestore
          .collection(collections)
          .where('userId', isEqualTo: user.uid)
          .where('date', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
          .where('date', isLessThan: endOfDay.toIso8601String())
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error');
    }
  }

  Future<bool> checkObatRecords() async {
    return await checkData('riwayat-obat');
  }

  Future<bool> checkDietRecords() async {
    return await checkData('diet-rendah-garam');
  }

  Future<bool> checkCairanRecords() async {
    return await checkData('pembatasan-cairan');
  }

  Future<bool> checkBeratRecords() async {
    return await checkData('berat');
  }

  Future<bool> checkOlahragaRecords() async {
    return await checkData('olahraga');
  }

  Future<bool> checkRokokRecords() async {
    return await checkData('rokok-alkohol');
  }
}
