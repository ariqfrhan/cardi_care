class CairanModel {
  final String id;
  final String userId;
  final String date;
  final double spoon;
  final String? imageUrl;
  final String? notes;

  CairanModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.spoon,
    required this.imageUrl,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'spoon': spoon,
      'imageUrl': imageUrl,
      'notes': notes,
    };
  }

  factory CairanModel.fromMap(Map<String, dynamic> map) {
    return CairanModel(
      id: map['id'],
      userId: map['userId'],
      date: map['date'],
      spoon: map['spoon'],
      imageUrl: map['imageUrl'],
      notes: map['notes'],
    );
  }
}
