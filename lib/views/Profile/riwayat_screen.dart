import 'package:cardi_care/services/edukasi_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserRiwayat extends StatelessWidget {
  const UserRiwayat({super.key});

  Future<List<QueryDocumentSnapshot>> fetchAllRecords() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    List<String> subCollections = [
      'riwayat_quiz',
      'olahraga',
      'berat',
      'diet-rendah-garam',
      'pembatasan-cairan',
      'riwayat-obat',
      'rokok-alkohol'
    ];
    List<QueryDocumentSnapshot> allRecords = [];

    for (String subCollection in subCollections) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('riwayat')
          .doc(user.uid)
          .collection(subCollection)
          .get();

      allRecords.addAll(snapshot.docs);
    }

    return allRecords;
  }

  String getUserActivity(String collectionName, Map<String, dynamic> data) {
    switch (collectionName) {
      case 'riwayat_quiz':
        return 'Riwayat Kuis ${data['materiId'] ?? ''}';
      case 'olahraga':
        return 'Aktivitas Fisik';
      case 'berat':
        return 'Berat Badan';
      case 'diet-rendah-garam':
        return 'Diet Rendah Garam';
      case 'pembatasan-cairan':
        return 'Pembatasan Cairan';
      case 'riwayat-obat':
        return 'Meminum obat ${data['nama'] ?? ''}';
      case 'rokok-alkohol':
        return 'Merokok & Alkohol';
      default:
        return 'Aktivitas Lain';
    }
  }

  String getSubtitle(String collectionName, Map<String, dynamic> data) {
    switch (collectionName) {
      case 'riwayat_quiz':
        List<dynamic> results = data['results'] ?? [];
        int correctCount = results
            .where((result) =>
                result['selectedAnswer'] == result['correctAnswerIndex'])
            .length;
        double scorePercentage = (correctCount / results.length) * 100;
        return "Skor: ${scorePercentage.toStringAsFixed(2)}% dari ${results.length} pertanyaan";
      case 'olahraga':
        return "Durasi olahraga : ${data['duration'] ?? ''} menit";
      case 'berat':
        return "Berat badan : ${data['weight'] ?? ''} kg";
      case 'diet-rendah-garam':
        return "Diet garam : ${data['spoon'] ?? ''} sendok";
      case 'pembatasan-cairan':
        return "Pembatasan cairan : ${data['spoon'] ?? ''} sendok";
      case 'riwayat-obat':
        return "Sudah minum : ${data['status'] ?? ''}";
      case 'rokok-alkohol':
        return "Merokok : ${data['merokok'] ?? ''}";
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          'Riwayat',
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: fetchAllRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text(''));
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              String collectionName = doc.reference.parent.id;
              String userActivity = getUserActivity(collectionName, data);
              String subtitle = getSubtitle(collectionName, data);
              DateTime? parsedDate;
              if (data['timestamp'] != null) {
                parsedDate = (data['timestamp'] as Timestamp).toDate();
              } else if (data['date'] != null) {
                parsedDate = DateTime.parse(data['date'].toString());
              }

              String formattedDate = parsedDate != null
                  ? DateFormat('EEEE, dd MMMM yyyy').format(parsedDate)
                  : 'Tanggal tidak tersedia';

              return ActivityListTile(
                userActivity: userActivity,
                subtitle: subtitle,
                formattedDate: formattedDate,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
