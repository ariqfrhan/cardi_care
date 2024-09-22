import 'package:cardi_care/views/TekaTekiSilang/types/item_datas.dart';

import '../models/tts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../types/history_answer.dart';

// ignore: constant_identifier_names
const String COLLECTION_NAME = 'crossword';

class TtsService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late final CollectionReference _ttsRef;

  Stream<QuerySnapshot> getTts() {
    return _ttsRef.snapshots();
  }

  Future<TtsModel> getTtsData(String id) async {
    DocumentSnapshot ttsData =
        await firestore.collection(COLLECTION_NAME).doc(id).get();

    return TtsModel.fromMap(ttsData.data() as Map<String, dynamic>);
  }

  Future<TtsModel> getTtsDataByMateriID(String id) async {
    try {
      QuerySnapshot ttsData = await firestore
          .collection(COLLECTION_NAME)
          .where('materiID', isEqualTo: id)
          .get();

      return TtsModel.fromMap(
          ttsData.docs.first.data() as Map<String, dynamic>);
    } catch (e) {
      Get.snackbar('No Crossword', 'No Crossword at here');
      return TtsModel(
        name: '',
        materiID: '',
        col: 0,
        row: 0,
        items: [],
      );
    }
  }

  Future<bool> saveQuizResult(
      String userId, String materiId, List<ItemDatas> questions) async {
    try {
      final CollectionReference riwayatCollection = firestore
          .collection('riwayat')
          .doc(userId)
          .collection('riwayat_crossword');

      // check is all question is already aswered
      for (var question in questions) {
        if (!question.isAnswered) {
          Get.snackbar('gagal menyimpan jawaban',
              'semua jawaban harus terisi untuk bisa menyimpan jawaban anda');
          return false;
        }
      }

      for (var question in questions) {
        await riwayatCollection.add({
          'userId': userId,
          'materiId': materiId,
          'timestamp': FieldValue.serverTimestamp(),
          'results': {
            'title': question.title,
            'direction': question.direction,
            'answer': question.answer,
            'startCol': question.startCol,
            'startRow': question.startRow,
            'number': question.number,
          },
        });
      }

      return true;
    } catch (e) {
      Get.snackbar('Error', 'gagal menyimpan hasil kuis');
      return false;
    }
  }

  Future<List<HistoryAnswers>> getHistoryAnswer(
      String userId, String materiId) async {
    final CollectionReference riwayatCollection = firestore
        .collection('riwayat')
        .doc(userId)
        .collection('riwayat_crossword');

    QuerySnapshot querySnapshot = await riwayatCollection
        .where('userId', isEqualTo: userId)
        .where('materiId', isEqualTo: materiId)
        .get();

    return querySnapshot.docs
        .map((e) => HistoryAnswers(
            materiId: e['materiId'],
            results: ItemDatas(
              title: e['results']['title'],
              direction: e['results']['direction'],
              answer: e['results']['answer'],
              startCol: e['results']['startCol'],
              startRow: e['results']['startRow'],
              number: e['results']['number'],
              isAnswered: true,
            ),
            timestamp: (e['timestamp'] as Timestamp).toDate(),
            userId: e['userId']))
        .toList();
  }
}
