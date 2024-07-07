class AdminModel {
  final String uid;
  final String name;
  final String email;

  AdminModel({required this.uid, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(uid: map['uid'], name: map['name'], email: map['email']);
  }
}
