class ObatModel {
  final String id;
  final String userId;
  final String nama;
  final DateTime date;
  final String status;

  ObatModel({
    required this.id,
    required this.userId,
    required this.nama,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'nama': nama,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  factory ObatModel.fromMap(Map<String, dynamic> map) {
    return ObatModel(
      id: map['id'],
      userId: map['userId'],
      nama: map['nama'],
      date: DateTime.parse(map['date']),
      status: map['status'],
    );
  }
}
