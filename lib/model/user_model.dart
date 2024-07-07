class UserModel {
  final String uid;
  final String name;
  final String email;
  final String tempatTL;
  final String gender;
  final String height;
  final String weight;
  final String familyId;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.tempatTL,
      required this.gender,
      required this.height,
      required this.weight,
      required this.familyId});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'tempatTL': tempatTL,
      'gender': gender,
      'height': height,
      'weight': weight,
      'familyId': familyId
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        tempatTL: map['tempatTL'],
        gender: map['gender'],
        height: map['height'],
        weight: map['weight'],
        familyId: map['familyId']);
  }
}
