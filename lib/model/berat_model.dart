class BeratModel {
  final String id;
  final String userId;
  final String date;
  final double weight;
  final String? imageUrl;
  final String? notes;

  BeratModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.weight,
    required this.imageUrl,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'weight': weight,
      'imageUrl': imageUrl,
      'notes': notes,
    };
  }

  factory BeratModel.fromMap(Map<String, dynamic> map) {
    return BeratModel(
      id: map['id'],
      userId: map['userId'],
      date: map['date'],
      weight: map['weight'],
      imageUrl: map['imageUrl'],
      notes: map['notes'],
    );
  }
}
