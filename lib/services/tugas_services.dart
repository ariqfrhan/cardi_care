import 'dart:io';

import 'package:cardi_care/model/berat_model.dart';
import 'package:cardi_care/model/cairan_model.dart';
import 'package:cardi_care/model/diet_model.dart';
import 'package:cardi_care/model/janji_temu_model.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserCredential? userCredential;
  FirebaseStorage storage = FirebaseStorage.instance;
  final Uuid uuid = const Uuid();

  Future<void> addOlahragaData(OlahragaModel olahraga) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        olahraga = OlahragaModel(
          id: firestore
              .collection('riwayat')
              .doc(user.uid)
              .collection('olahraga')
              .doc()
              .id,
          userId: user.uid,
          date: olahraga.date,
          type: olahraga.type,
          duration: olahraga.duration,
          notes: olahraga.notes,
        );

        await firestore
            .collection('riwayat')
            .doc(user.uid)
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
          id: firestore
              .collection('riwayat')
              .doc(user.uid)
              .collection('rokok-alkohol')
              .doc()
              .id,
          userId: user.uid,
          date: rokok.date,
          merokok: rokok.merokok,
          alkohol: rokok.alkohol,
          notes: rokok.notes,
        );

        await firestore
            .collection('riwayat')
            .doc(user.uid)
            .collection('rokok-alkohol')
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
      }

      final beratData = BeratModel(
        id: firestore
            .collection('riwayat')
            .doc(user.uid)
            .collection('berat')
            .doc()
            .id,
        userId: user.uid,
        date: date,
        weight: weight,
        imageUrl: imageUrl,
        notes: notes,
      );

      await firestore
          .collection('riwayat')
          .doc(user.uid)
          .collection('berat')
          .doc(beratData.id)
          .set(beratData.toMap());

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
      }

      final cairanData = CairanModel(
        id: firestore
            .collection('riwayat')
            .doc(user.uid)
            .collection('pembatasan-cairan')
            .doc()
            .id,
        userId: user.uid,
        date: date,
        spoon: spoon,
        imageUrl: imageUrl,
        notes: notes,
      );

      await firestore
          .collection('riwayat')
          .doc(user.uid)
          .collection('pembatasan-cairan')
          .doc(cairanData.id)
          .set(cairanData.toMap());

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
      }

      final dietData = DietModel(
        id: firestore
            .collection('riwayat')
            .doc(user.uid)
            .collection('diet-rendah-garam')
            .doc()
            .id,
        userId: user.uid,
        date: date,
        spoon: spoon,
        imageUrl: imageUrl,
        notes: notes,
      );

      await firestore
          .collection('riwayat')
          .doc(user.uid)
          .collection('diet-rendah-garam')
          .doc(dietData.id)
          .set(dietData.toMap());

      Get.snackbar('Success', 'Data aktivitas berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addObatData(
      String namaObat, List<DateTime> times, String userId) async {
    try {
      for (DateTime time in times) {
        final obatData = ObatModel(
          id: firestore.collection('obat').doc().id,
          userId: userId,
          nama: namaObat,
          date: time,
          status: '',
        );
        await firestore
            .collection('obat')
            .doc(obatData.id)
            .set(obatData.toMap());
      }

      Get.snackbar('Success', 'Data obat berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteObat(String obatId) async {
    try {
      await firestore.collection('obat').doc(obatId).delete();
      Get.snackbar('Success', 'Obat berhasil dihapus');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateObat(String obatId, String namaObat, List<DateTime> times,
      String userId) async {
    try {
      for (DateTime time in times) {
        final obatData = ObatModel(
          id: obatId,
          userId: userId,
          nama: namaObat,
          date: time,
          status: '',
        );
        await firestore
            .collection('obat')
            .doc(obatData.id)
            .update(obatData.toMap());
      }

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
          .get(const GetOptions(source: Source.serverAndCache));

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

      final obatData = ObatModel(
        id: firestore
            .collection('riwayat')
            .doc(user.uid)
            .collection('riwayat-obat')
            .doc()
            .id,
        userId: user.uid,
        nama: obat.nama,
        date: DateTime.now(),
        status: obat.status,
      );

      await firestore
          .collection('riwayat')
          .doc(user.uid)
          .collection('riwayat-obat')
          .doc(obatData.id)
          .set(obatData.toMap());

      Get.snackbar(
          'Success', 'Data riwayat konsumsi obat berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addJanjiTemu(JanjiTemuModel janjiTemu) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      String newId = firestore
          .collection('riwayat')
          .doc(user.uid)
          .collection('janji-temu')
          .doc()
          .id;
      janjiTemu = JanjiTemuModel(
        id: newId,
        userId: janjiTemu.userId,
        date: janjiTemu.date,
        status: janjiTemu.status,
      );

      await firestore
          .collection('riwayat')
          .doc(janjiTemu.userId)
          .collection('janji-temu')
          .doc(janjiTemu.id)
          .set(janjiTemu.toMap());

      Get.snackbar('Success', 'Janji temu berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<List<JanjiTemuModel>> getJanjiTemuByUserId(String userId) async {
    try {
      final snapshot = await firestore
          .collection('riwayat')
          .doc(userId)
          .collection('janji-temu')
          .get(const GetOptions(source: Source.serverAndCache));

      return snapshot.docs
          .map((doc) => JanjiTemuModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  List<JanjiTemuModel> getClosestAppointment(
      List<JanjiTemuModel> appointments) {
    final now = DateTime.now();
    appointments.sort((a, b) {
      final dateA = DateTime.parse(a.date);
      final dateB = DateTime.parse(b.date);
      return dateA.difference(now).abs().compareTo(dateB.difference(now).abs());
    });
    return [appointments.first];
  }
}
