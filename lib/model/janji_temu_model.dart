class JanjiTemuModel {
  final String id;
  final String userId;
  final String date;
  final String? status;

  JanjiTemuModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'status': status,
    };
  }

  factory JanjiTemuModel.fromMap(Map<String, dynamic> map) {
    return JanjiTemuModel(
      id: map['id'],
      userId: map['userId'],
      date: map['date'],
      status: map['status'],
    );
  }
}
