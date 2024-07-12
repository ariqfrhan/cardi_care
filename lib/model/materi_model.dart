class MateriModel {
  final String uid;
  final String nama;
  final String materi;
  final bool status;

  MateriModel(
      {required this.uid,
      required this.nama,
      required this.materi,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': nama,
      'materi': materi,
      'status': status,
    };
  }

  factory MateriModel.fromMap(Map<String, dynamic> map) {
    return MateriModel(
        uid: map['id'],
        nama: map['nama'],
        materi: map['materi'],
        status: map['status']);
  }
}
