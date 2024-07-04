import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;

  Future<void> signUpWithEmail(
      String email, String password, UserModel user) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        userCredential = value;
        Get.offAllNamed(Routes.mainWrapper);

        user = UserModel(
          uid: value.user!.uid,
          name: user.name,
          email: user.email,
          tempatTL: user.tempatTL,
          gender: user.gender,
          height: user.height,
          weight: user.weight,
        );

        await firestore
            .collection("users")
            .doc(value.user!.uid)
            .set(user.toMap());
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> logInWithEmail(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Get.offAllNamed(Routes.mainWrapper);
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          Get.snackbar('Login Failed', 'Incorrect email or password');
        } else {
          Get.snackbar('Login Failed', 'An error occurred during login');
        }
      } else {
        Get.snackbar('Login Failed', 'An error occurred during login');
      }
    }
  }

  Future<UserModel> getUserData() async {
    User? user = _auth.currentUser;
    DocumentSnapshot userData =
        await firestore.collection('users').doc(user!.uid).get();

    return UserModel.fromMap(userData.data() as Map<String, dynamic>);
  }
}
