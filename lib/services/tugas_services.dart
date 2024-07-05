import 'dart:io';

import 'package:cardi_care/model/berat_model.dart';
import 'package:cardi_care/model/cairan_model.dart';
import 'package:cardi_care/model/diet_model.dart';
import 'package:cardi_care/model/obat_model.dart';
import 'package:cardi_care/model/olahraga_model.dart';
import 'package:cardi_care/model/rokok_alkohol_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class TugasServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserCredential? userCredential;
  FirebaseStorage storage = FirebaseStorage.instance;
  final Uuid uuid = Uuid();

  Future<void> addOlahragaData(OlahragaModel olahraga) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        olahraga = OlahragaModel(
          id: firestore.collection('aktivitas').doc().id,
          userId: user.uid,
          date: olahraga.date,
          type: olahraga.type,
          duration: olahraga.duration,
          notes: olahraga.notes,
        );

        await firestore
            .collection('olahraga')
            .doc(olahraga.id)
            .set(olahraga.toMap());

        Get.snackbar('Success', 'Data aktivitas berhasil ditambahkan');
      } else {
        Get.snackbar('Error', 'User tidak ditemukan');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addRokokAlkoholData(RokokAlkoholModel rokok) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        rokok = RokokAlkoholModel(
          id: firestore.collection("rokok-alkohol").doc().id,
          userId: user.uid,
          date: rokok.date,
          merokok: rokok.merokok,
          alkohol: rokok.alkohol,
          notes: rokok.notes,
        );

        await firestore
            .collection("rokok-alkohol")
            .doc(rokok.id)
            .set(rokok.toMap());
        Get.snackbar(
            'Success', 'Data aktivitas rokok dan alkohol berhasil ditambahkan');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addBeratData(
      String date, double weight, XFile? image, String? notes) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      String imageUrl = "";
      if (image != null) {
        final String imagePath = 'images/${uuid.v4()}.jpg';
        final UploadTask uploadTask =
            storage.ref().child(imagePath).putFile(File(image.path));
        final TaskSnapshot downloadUrl = await uploadTask;
        imageUrl = await downloadUrl.ref.getDownloadURL();

        final beratId = uuid.v4();
        final beratData = BeratModel(
            id: beratId,
            userId: user.uid,
            date: date,
            weight: weight,
            imageUrl: imageUrl,
            notes: notes);

        await firestore.collection('berat').doc(beratId).set(beratData.toMap());
      }
      Get.snackbar('Success', 'Data berat badan berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addCairanData(
      String date, double spoon, XFile? image, String? notes) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      String imageUrl = "";
      if (image != null) {
        final String imagePath = 'images/${uuid.v4()}.jpg';
        final UploadTask uploadTask =
            storage.ref().child(imagePath).putFile(File(image.path));
        final TaskSnapshot downloadUrl = await uploadTask;
        imageUrl = await downloadUrl.ref.getDownloadURL();

        final cairanId = uuid.v4();
        final cairanData = CairanModel(
            id: cairanId,
            userId: user.uid,
            date: date,
            spoon: spoon,
            imageUrl: imageUrl,
            notes: notes);

        await firestore
            .collection('pembatasan-cairan')
            .doc(cairanId)
            .set(cairanData.toMap());
      }
      Get.snackbar('Success', 'Data pembatasan cairan berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addDietData(
      String date, double spoon, XFile? image, String? notes) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      String imageUrl = "";
      if (image != null) {
        final String imagePath = 'images/${uuid.v4()}.jpg';
        final UploadTask uploadTask =
            storage.ref().child(imagePath).putFile(File(image.path));
        final TaskSnapshot downloadUrl = await uploadTask;
        imageUrl = await downloadUrl.ref.getDownloadURL();

        final dietId = uuid.v4();
        final dietData = DietModel(
            id: dietId,
            userId: user.uid,
            date: date,
            spoon: spoon,
            imageUrl: imageUrl,
            notes: notes);

        await firestore
            .collection('diet-rendah-garam')
            .doc(dietId)
            .set(dietData.toMap());
      }
      Get.snackbar('Success', 'Data aktivitas berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addObatData(ObatModel obat) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final obatId = uuid.v4();
      final obatData = ObatModel(
        id: obatId,
        userId: user.uid,
        nama: obat.nama,
        date: obat.date,
        status: obat.status,
      );

      await firestore.collection('obat').doc(obatId).set(obatData.toMap());

      Get.snackbar('Success', 'Data obat berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<List<ObatModel>> getObatDataByUserId(String userId) async {
    try {
      final snapshot = await firestore
          .collection('obat')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => ObatModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<void> addRiwayatObatPasienData(ObatModel obat) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final obatId = uuid.v4();
      final obatData = ObatModel(
        id: obatId,
        userId: user.uid,
        nama: obat.nama,
        date: DateTime.now(),
        status: obat.status,
      );

      await firestore
          .collection('riwayat-obat')
          .doc(obatId)
          .set(obatData.toMap());

      Get.snackbar(
          'Success', 'Data riwayat konsumsi obat berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
