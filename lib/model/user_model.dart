class UserModel {
  final String uid;
  final String name;
  final String email;
  final String tempatTL;
  final String gender;
  final String height;
  final String weight;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.tempatTL,
    required this.gender,
    required this.height,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'tempatTL': tempatTL,
      'gender': gender,
      'height': height,
      'weight': weight,
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
    );
  }
}
