class AdminModel {
  final String uid;
  final String name;
  final String email;
  final String handphone;

  AdminModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.handphone});

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'email': email, 'handphone': handphone};
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        handphone: map['handphone']);
  }
}
