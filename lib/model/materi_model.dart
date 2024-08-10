class MateriModel {
  final String uid;
  final String nama;
  final String materi;
  final bool status;
  final List<String> videoUrl;

  MateriModel(
      {required this.uid,
      required this.nama,
      required this.materi,
      required this.status,
      required this.videoUrl});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': nama,
      'materi': materi,
      'status': status,
      'videoUrl': videoUrl
    };
  }

  factory MateriModel.fromMap(Map<String, dynamic> map) {
    return MateriModel(
      uid: map['id'],
      nama: map['nama'],
      materi: map['materi'],
      status: map['status'],
      videoUrl: List<String>.from(map['videoUrl'] ?? []),
    );
  }
}
