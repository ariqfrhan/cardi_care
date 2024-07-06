import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ActivityListTile extends StatelessWidget {
  final String collectionName;
  final String userActivity;
  final String subtitleField;

  const ActivityListTile({
    super.key,
    required this.collectionName,
    required this.userActivity,
    required this.subtitleField,
  });

  Future<QuerySnapshot> fetchRecords() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: user.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: fetchRecords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No records found'));
        }

        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            String subtitle = data[subtitleField]?.toString() ?? '';
            String date = data['date']?.toString() ?? '';

            DateTime parsedDate = DateTime.parse(date);
            String formattedDate =
                DateFormat('EEEE, dd MMMM yyyy').format(parsedDate);

            String subText = '';
            if (collectionName == 'olahraga') {
              subText = "Durasi olahraga : $subtitle menit";
            } else if (collectionName == 'berat') {
              subText = "Berat badan : $subtitle kg";
            } else if (collectionName == 'diet-rendah-garam') {
              subText = "Diet garam : $subtitle sendok";
            } else if (collectionName == 'pembatasan-cairan') {
              subText = "Pembatasan cairan : $subtitle sendok";
            } else if (collectionName == 'riwayat-obat') {
              subText = "Sudah minum : $subtitle";
            } else if (collectionName == 'rokok-alkohol') {
              subText = "Merokok : $subtitle";
            }

            return ListTile(
              title: Text(
                userActivity,
                style: redText.copyWith(fontSize: 14, fontWeight: bold),
              ),
              subtitle: Text(subText),
              trailing: Text(formattedDate),
              shape: LinearBorder.bottom(
                side: const BorderSide(color: Colors.black, width: 0.8),
              ),
              visualDensity: const VisualDensity(vertical: 2),
            );
          }).toList(),
        );
      },
    );
  }
}
