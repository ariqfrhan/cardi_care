import '../models/tts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
          .where('materi_id', isEqualTo: id)
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
}
