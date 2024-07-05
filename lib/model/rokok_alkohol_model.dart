class RokokAlkoholModel {
  final String id;
  final String userId;
  final String date;
  final String merokok;
  final String alkohol;
  final String? notes;

  RokokAlkoholModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.merokok,
    required this.alkohol,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'merokok': merokok,
      'alkohol': alkohol,
      'notes': notes,
    };
  }

  factory RokokAlkoholModel.fromMap(Map<String, dynamic> map) {
    return RokokAlkoholModel(
      id: map['id'],
      userId: map['userId'],
      date: map['date'],
      merokok: map['merokok'],
      alkohol: map['alkohol'],
      notes: map['notes'],
    );
  }
}
