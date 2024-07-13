import 'package:cardi_care/model/materi_model.dart';
import 'package:cardi_care/model/quiz_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/services/edukasi_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/cards.dart';
import 'package:cardi_care/views/widgets/quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final MateriModel materi = Get.arguments;
  late Future<List<QuizModel>> futureQuestions;
  List<int?> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    futureQuestions = EdukasiServices().getAllQuiz(materi.uid);
    futureQuestions.then((questions) {
      setState(() {
        selectedAnswers = List<int?>.filled(questions.length, null);
      });
    });
  }

  void _submitQuiz(
      List<QuizModel> questions, List<int?> selectedAnswers) async {
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }

    final FirebaseAuth auth = FirebaseAuth.instance;
    User? userId = auth.currentUser;

    await EdukasiServices()
        .saveQuizResult(userId!.uid, materi.uid, questions, selectedAnswers);

    Get.snackbar(
        'Quiz Submitted', 'You answered $correctAnswers questions correctly.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        foregroundColor: red950,
        title: Text(
          'Quiz',
          style: blackText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<List<QuizModel>>(
          future: futureQuestions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No quiz available'));
            }

            List<QuizModel> questions = snapshot.data!;

            return Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Tema',
                  style: blackText.copyWith(
                      fontSize: 14, fontWeight: bold, color: redColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      materi.nama,
                      style: blackText.copyWith(fontSize: 22, fontWeight: bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Text(
                  '${questions.length} pertanyaan',
                  style: blackText.copyWith(
                      fontSize: 14, fontWeight: bold, color: mono600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return QuizQuestionWidget(
                        question: QuizQuestion(
                          question: questions[index].question,
                          options: questions[index].options,
                          correctAnswerIndex:
                              questions[index].correctAnswerIndex,
                        ),
                        onAnswerSelected: (selectedIndex) {
                          setState(() {
                            selectedAnswers[index] = selectedIndex;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomRedButton(
          title: 'Submit',
          onPressed: () async {
            List<QuizModel> questions = await futureQuestions;
            _submitQuiz(questions, selectedAnswers);
            Get.offAllNamed(Routes.mainWrapper);
          },
        ),
      ),
    );
  }
}
