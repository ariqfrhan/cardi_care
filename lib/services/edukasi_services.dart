import 'package:cardi_care/model/materi_model.dart';
import 'package:cardi_care/model/quiz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EdukasiServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<MateriModel>> getAllMateri() async {
    QuerySnapshot snapshot = await firestore.collection("materi").get(
          const GetOptions(source: Source.serverAndCache),
        );

    return snapshot.docs
        .map((doc) => MateriModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<QuizModel>> getAllQuiz(String materiId) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection("quiz")
          .where('materiId', isEqualTo: materiId)
          .get(const GetOptions(source: Source.serverAndCache));

      return snapshot.docs
          .map((doc) => QuizModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('No Quiz', 'No quiz at here');
      return [];
    }
  }

  Future<void> saveQuizResult(String userId, String materiId,
      List<QuizModel> questions, List<int?> selectedAnswers) async {
    final CollectionReference riwayatCollection =
        firestore.collection('riwayat').doc(userId).collection('riwayat_quiz');

    List<Map<String, dynamic>> quizResults = [];
    for (int i = 0; i < questions.length; i++) {
      quizResults.add({
        'question': questions[i].question,
        'options': questions[i].options,
        'selectedAnswer': selectedAnswers[i],
        'correctAnswerIndex': questions[i].correctAnswerIndex,
      });
    }

    await riwayatCollection.add({
      'userId': userId,
      'materiId': materiId,
      'timestamp': FieldValue.serverTimestamp(),
      'results': quizResults,
    });
  }

  Future<bool> hasCompletedQuiz(String userId, String materiId) async {
    QuerySnapshot snapshot = await firestore
        .collection('riwayat')
        .doc(userId)
        .collection('riwayat_quiz')
        .where('materiId', isEqualTo: materiId)
        .get(const GetOptions(source: Source.serverAndCache));

    return snapshot.docs.isNotEmpty;
  }
}
