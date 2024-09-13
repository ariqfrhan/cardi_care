import 'package:cardi_care/model/AdminModel/admin_model.dart';
import 'package:cardi_care/model/KeluargaModel/keluarga_model.dart';
import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserCredential? userCredential;

  Future<void> signUpWithEmail(
      String email, String password, UserModel user) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        userCredential = value;
        Get.offAllNamed(Routes.splashDaftar);

        user = UserModel(
            uid: value.user!.uid,
            name: user.name,
            email: user.email,
            tempatTL: user.tempatTL,
            bloodPressure: user.bloodPressure,
            gender: user.gender,
            height: user.height,
            weight: user.weight,
            familyId: user.familyId);

        await firestore
            .collection("users")
            .doc(value.user!.uid)
            .set(user.toMap());

        await firestore.collection('keluarga').doc(user.familyId).update({
          'userIds': FieldValue.arrayUnion([user.uid]),
        });
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> keluargaSignUp(
      String email, String password, KeluargaModel keluarga) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        keluarga = KeluargaModel(
            uid: value.user!.uid,
            name: keluarga.name,
            userIds: [],
            email: keluarga.email);

        await firestore
            .collection("keluarga")
            .doc(value.user!.uid)
            .set(keluarga.toMap());
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<bool> logInWithEmail(String email, String password,
      {required String userType}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userType == 'admin') {
        bool isAdmin = await isUserAdmin(userCredential.user!.uid);
        if (!isAdmin) {
          await _auth.signOut();
          Get.snackbar(
              'Login Failed', 'Akun ini tidak terdaftar sebagai admin');
          return false;
        }
      }

      if (userType == 'keluarga') {
        bool isAdmin = await isUserKeluarga(userCredential.user!.uid);
        if (!isAdmin) {
          await _auth.signOut();
          Get.snackbar(
              'Login Failed', 'Akun ini tidak terdaftar sebagai keluarga');
          return false;
        }
      }

      if (userType == 'pasien') {
        bool isAdmin = await isUserPasien(userCredential.user!.uid);
        if (!isAdmin) {
          await _auth.signOut();
          Get.snackbar(
              'Login Failed', 'Akun ini tidak terdaftar sebagai pasien');
          return false;
        }
      }

      return true;
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
      return false;
    }
  }

  Future<bool> isUserAdmin(String uid) async {
    try {
      DocumentSnapshot adminDoc =
          await firestore.collection('admin').doc(uid).get();
      return adminDoc.exists;
    } catch (e) {
      // print('Error checking admin status: $e');
      return false;
    }
  }

  Future<bool> isUserPasien(String uid) async {
    try {
      DocumentSnapshot adminDoc =
          await firestore.collection('users').doc(uid).get();
      return adminDoc.exists;
    } catch (e) {
      // print('Error checking admin status: $e');
      return false;
    }
  }

  Future<bool> isUserKeluarga(String uid) async {
    try {
      DocumentSnapshot adminDoc =
          await firestore.collection('keluarga').doc(uid).get();
      return adminDoc.exists;
    } catch (e) {
      // print('Error checking admin status: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.splash);
  }

  Future<UserModel> getUserData() async {
    User? user = _auth.currentUser;
    DocumentSnapshot userData = await firestore
        .collection('users')
        .doc(user!.uid)
        .get(const GetOptions(source: Source.serverAndCache));

    return UserModel.fromMap(userData.data() as Map<String, dynamic>);
  }

  Future<UserModel> getUserDataById(String userId) async {
    DocumentSnapshot userData = await firestore
        .collection('users')
        .doc(userId)
        .get(const GetOptions(source: Source.serverAndCache));

    return UserModel.fromMap(userData.data() as Map<String, dynamic>);
  }

  Future<KeluargaModel> getKeluargaData() async {
    User? keluarga = _auth.currentUser;
    DocumentSnapshot keluargaData =
        await firestore.collection('keluarga').doc(keluarga!.uid).get();

    return KeluargaModel.fromMap(keluargaData.data() as Map<String, dynamic>);
  }

  Future<AdminModel> getAdminData() async {
    User? admin = _auth.currentUser;
    DocumentSnapshot adminData =
        await firestore.collection('admin').doc(admin!.uid).get();

    return AdminModel.fromMap(adminData.data() as Map<String, dynamic>);
  }

  Future<String?> getAdminPhoneNumber() async {
    try {
      DocumentSnapshot adminData = await firestore
          .collection('admin')
          .doc('T0ATY1zjv1PifODYFjoPzIln4fm2')
          .get(const GetOptions(source: Source.serverAndCache));
      if (adminData.exists) {
        return adminData['handphone'];
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return null;
  }
}
