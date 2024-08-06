import 'package:cardi_care/model/janji_temu_model.dart';
import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/services/record_service.dart';
import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/shared/utils.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  JanjiTemuModel? closestJanjiTemu;
  String? adminPhoneNumber;

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

  void fetchClosestJanjiTemu() async {
  UserModel user = await AuthServices().getUserData();
  List<JanjiTemuModel> janjis =
      await TugasServices().getJanjiTemuByUserId(user.uid);
  if (janjis.isNotEmpty) {
    final now = DateTime.now();
    janjis.sort((a, b) {
      final dateA = DateTime.parse(a.date);
      final dateB = DateTime.parse(b.date);
      return dateA.compareTo(dateB);
    });

    JanjiTemuModel? nextJanjiTemu;
    for (JanjiTemuModel janji in janjis) {
      final dateTime = DateTime.parse(janji.date);
      if (dateTime.isAfter(now)) {
        nextJanjiTemu = janji;
        break;
      }
    }

    setState(() {
      closestJanjiTemu = nextJanjiTemu;
    });
  } else {
    setState(() {
      closestJanjiTemu = null;
    });
  }
}

  void fetchAdminPhoneNumber() async {
    adminPhoneNumber = await AuthServices().getAdminPhoneNumber();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchClosestJanjiTemu();
    fetchAdminPhoneNumber();
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
                  height: 20,
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
                  height: 5,
                ),
                closestJanjiTemu != null
                    ? ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: pinkColor,
                        leading: Icon(
                          Icons.calendar_month,
                          color: redColor,
                        ),
                        title: const Text('Janji Temu Dokter'),
                        subtitle: Text(closestJanjiTemu!.status ?? ''),
                        trailing: Text(
                            Utils.formatDateJanjiTemu(closestJanjiTemu!.date)),
                      )
                    : const SizedBox.shrink(),
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
                        return const Center(child: CircularProgressIndicator());
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
                              enabled: !(check['olahragaCount'] ?? false),
                            ),
                            FeatureButtons(
                              title: 'Diet Rendah Garam',
                              icons: Icons.rice_bowl,
                              status: check['dietCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userDiet);
                              },
                              enabled: !(check['dietCount'] ?? false),
                            ),
                            FeatureButtons(
                              title: 'Konsumsi Obat',
                              icons: Icons.medication_outlined,
                              status: check['obatCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userObat);
                              },
                              enabled: !(check['obatCount'] ?? false),
                            ),
                            FeatureButtons(
                              title: 'Berat Badan',
                              icons: Icons.monitor_weight,
                              status: check['beratCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userBerat);
                              },
                              enabled: !(check['beratCount'] ?? false),
                            ),
                            FeatureButtons(
                              title: 'Pembatasan Cairan',
                              icons: Icons.water,
                              status: check['cairanCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userCairan);
                              },
                              enabled: !(check['cairanCount'] ?? false),
                            ),
                            FeatureButtons(
                              title: 'Merokok & Alkohol',
                              icons: Icons.no_drinks,
                              status: check['rokokCount'] ?? false,
                              onPressed: () {
                                Get.toNamed(Routes.userMerokokAlkohol);
                              },
                              enabled: !(check['rokokCount'] ?? false),
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
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kamu mengalami keluhan? \nSampaikan disini!',
                      style: blackText.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomRedButton(
                      title: 'Keluhan',
                      onPressed: () async {
                        await launchUrlString(
                            mode: LaunchMode.externalApplication,
                            "https://wa.me/$adminPhoneNumber?text=Saya%20punya%20keluhan");
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
