import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/cards.dart';
import 'package:flutter/material.dart';

class UserRiwayat extends StatelessWidget {
  const UserRiwayat({super.key});

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
      body: ListView(
        children: const [
          ActivityListTile(
            collectionName: 'olahraga',
            userActivity: 'Aktivitas Fisik',
            subtitleField: 'duration',
          ),
          ActivityListTile(
            collectionName: 'berat',
            userActivity: 'Berat Badan',
            subtitleField: 'weight',
          ),
          ActivityListTile(
            collectionName: 'diet-rendah-garam',
            userActivity: 'Diet Rendah Garam',
            subtitleField: 'spoon',
          ),
          ActivityListTile(
            collectionName: 'pembatasan-cairan',
            userActivity: 'Pembatasan Cairan',
            subtitleField: 'spoon',
          ),
          ActivityListTile(
            collectionName: 'riwayat-obat',
            userActivity: 'Meminum obat',
            subtitleField: 'status',
          ),
          ActivityListTile(
            collectionName: 'rokok-alkohol',
            userActivity: 'Merokok & Alkohol',
            subtitleField: 'merokok',
          ),
        ],
      ),
    );
  }
}
