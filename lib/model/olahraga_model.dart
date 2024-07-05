class OlahragaModel {
  final String id;
  final String userId;
  final String date;
  final String type;
  final String duration;
  final String? notes;

  OlahragaModel(
      {required this.id,
      required this.userId,
      required this.date,
      required this.type,
      required this.duration,
      required this.notes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'type': type,
      'duration': duration,
      'notes': notes,
    };
  }

  factory OlahragaModel.fromMap(Map<String, dynamic> map) {
    return OlahragaModel(
      id: map['id'],
      userId: map['userId'],
      date: map['date'],
      type: map['type'],
      duration: map['duration'],
      notes: map['notes'],
    );
  }
}
