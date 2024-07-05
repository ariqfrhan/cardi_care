import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServices auth = Get.find<AuthServices>();
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 64,
                ),
                FutureBuilder(
                    future: auth.getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('No user data found'));
                      }

                      UserModel user = snapshot.data!;
                      return Text(
                        'Halo, ${user.name}',
                        style: blackText.copyWith(
                            fontSize: 22, fontWeight: semibold),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: pinkColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Tugas Harian',
                        style: blackText.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                      ),
                      FeatureButtons(
                        title: 'Aktivitas',
                        icons: Icons.man,
                        status: false,
                        onPressed: () {
                          Get.toNamed(Routes.userOlahraga);
                        },
                      ),
                      FeatureButtons(
                        title: 'Diet Rendah Garam',
                        icons: Icons.rice_bowl,
                        status: true,
                        onPressed: () {
                          Get.toNamed(Routes.userDiet);
                        },
                      ),
                      FeatureButtons(
                        title: 'Konsumsi Obat',
                        icons: Icons.medication_outlined,
                        status: false,
                        onPressed: () {
                          Get.toNamed(Routes.userObat);
                        },
                      ),
                      FeatureButtons(
                        title: 'Berat Badan',
                        icons: Icons.monitor_weight,
                        status: false,
                        onPressed: () {
                          Get.toNamed(Routes.userBerat);
                        },
                      ),
                      FeatureButtons(
                        title: 'Pembatasan Cairan',
                        icons: Icons.water,
                        status: false,
                        onPressed: () {
                          Get.toNamed(Routes.userCairan);
                        },
                      ),
                      FeatureButtons(
                        title: 'Merokok & Alkohol',
                        icons: Icons.no_drinks,
                        status: true,
                        onPressed: () {
                          Get.toNamed(Routes.userMerokokAlkohol);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
