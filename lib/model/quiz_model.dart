class QuizModel {
  final String uid;
  final String materiId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizModel({
    required this.uid,
    required this.materiId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'materiId': materiId,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      uid: map['id'],
      materiId: map['materiId'],
      question: map['question'],
      options: List<String>.from(map['options']),
      correctAnswerIndex: map['correctAnswerIndex'],
    );
  }
}
