class KeluargaModel {
  final String uid;
  final String name;
  final String email;
  final List<String> userIds;

  KeluargaModel(
      {required this.uid,
      required this.name,
      required this.userIds,
      required this.email});

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'userIds': userIds, 'email': email};
  }

  factory KeluargaModel.fromMap(Map<String, dynamic> map) {
    return KeluargaModel(
        uid: map['uid'],
        name: map['name'],
        userIds: List<String>.from(map['userIds']),
        email: map['email']);
  }
}
