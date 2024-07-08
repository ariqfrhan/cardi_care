import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EdukasiScreen extends StatelessWidget {
  const EdukasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServices auth = Get.find<AuthServices>();
    return Scaffold(
      body: FutureBuilder(
          future: auth.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No user data found'));
            }
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Edukasi',
                      style: blackText.copyWith(fontSize: 22, fontWeight: bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                EducationCard(nama: 'Seputar Gagal Jantung'),
                const SizedBox(
                  height: 12,
                ),
                EducationCard(
                  nama: 'Self Care',
                  enabled: false,
                ),
              ],
            );
          }),
    );
  }
}
