class RiwayatQuizModel {
  final String userId;
  final String materiId;
  final DateTime timestamp;
  final List<Map<String, dynamic>> results;

  RiwayatQuizModel({
    required this.userId,
    required this.materiId,
    required this.timestamp,
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'materiId': materiId,
      'timestamp': timestamp.toIso8601String(),
      'results': results,
    };
  }

  factory RiwayatQuizModel.fromMap(Map<String, dynamic> map) {
    return RiwayatQuizModel(
      userId: map['userId'],
      materiId: map['materiId'],
      timestamp: map['timestamp'].toIso8601String(),
      results: List<Map<String, dynamic>>.from(map['results']),
    );
  }

  int getCorrectAnswersCount() {
    return results
        .where((result) =>
            result['selectedAnswer'] == result['correctAnswerIndex'])
        .length;
  }
}
