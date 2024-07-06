import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/services/record_service.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map<String, bool>> fetchData() async {
    try {
      bool obatCount = await RecordService().checkObatRecords();
      bool dietCount = await RecordService().checkDietRecords();
      bool cairanCount = await RecordService().checkCairanRecords();
      bool beratCount = await RecordService().checkBeratRecords();
      bool olahragaCount = await RecordService().checkOlahragaRecords();
      bool rokokCount = await RecordService().checkRokokRecords();

      return {
        'obatCount': obatCount,
        'dietCount': dietCount,
        'cairanCount': cairanCount,
        'beratCount': beratCount,
        'olahragaCount': olahragaCount,
        'rokokCount': rokokCount,
      };
    } catch (e) {
      throw Exception('Error fetching status: $e');
    }
  }

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
                  child: FutureBuilder<Map<String, bool>>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        final check = snapshot.data!;
                        return Column(
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
                              status: check['olahragaCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userOlahraga);
                              },
                            ),
                            FeatureButtons(
                              title: 'Diet Rendah Garam',
                              icons: Icons.rice_bowl,
                              status: check['dietCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userDiet);
                              },
                            ),
                            FeatureButtons(
                              title: 'Konsumsi Obat',
                              icons: Icons.medication_outlined,
                              status: check['obatCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userObat);
                              },
                            ),
                            FeatureButtons(
                              title: 'Berat Badan',
                              icons: Icons.monitor_weight,
                              status: check['beratCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userBerat);
                              },
                            ),
                            FeatureButtons(
                              title: 'Pembatasan Cairan',
                              icons: Icons.water,
                              status: check['cairanCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userCairan);
                              },
                            ),
                            FeatureButtons(
                              title: 'Merokok & Alkohol',
                              icons: Icons.no_drinks,
                              status: check['rokokCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userMerokokAlkohol);
                              },
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text('No data available'),
                        );
                      }
                    },
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
