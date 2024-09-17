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

  Future<void> saveQuizResult(String userId, String materiId,
      ItemDatas questions, String answer) async {
    try {
      final CollectionReference riwayatCollection = firestore
          .collection('riwayat')
          .doc(userId)
          .collection('riwayat_crossword');

      await riwayatCollection.add({
        'userId': userId,
        'materiId': materiId,
        'timestamp': FieldValue.serverTimestamp(),
        'results': {
          'title': questions.title,
          'direction': questions.direction,
          'answer': questions.answer,
          'startCol': questions.startCol,
          'startRow': questions.startRow,
          'number': questions.number,
        },
      });
    } catch (e) {
      Get.snackbar('Error', 'Error saving quiz result');
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
