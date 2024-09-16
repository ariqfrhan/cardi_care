import 'package:cardi_care/model/KeluargaModel/keluarga_model.dart';
import 'package:cardi_care/model/janji_temu_model.dart';
import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/shared/utils.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class KeluargaProfile extends StatefulWidget {
  const KeluargaProfile({super.key});

  @override
  State<KeluargaProfile> createState() => _KeluargaProfileState();
}

class _KeluargaProfileState extends State<KeluargaProfile> {
  JanjiTemuModel? closestJanjiTemu;
  UserModel? fetchedUser;
  String? adminPhoneNumber;

  void fetchClosestJanjiTemu() async {
    KeluargaModel keluarga = await AuthServices().getKeluargaData();
    UserModel user =
        await AuthServices().getUserDataById(keluarga.userIds.first);
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
        fetchedUser = user;
      });
    } else {
      setState(() {
        closestJanjiTemu = null;
        fetchedUser = user;
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
      body: FutureBuilder(
        future: auth.getKeluargaData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data found'));
          }

          KeluargaModel user = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 86),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.person,
                      color: whiteColor,
                      size: 112,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.name,
                          style: blackText.copyWith(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // const ProfileButtons(title: 'Pengaturan'),

              closestJanjiTemu != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jadwal janji temu untuk ${fetchedUser!.name}',
                          style: blackText.copyWith(
                              fontWeight: semibold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          tileColor: pinkColor,
                          leading: Icon(
                            Icons.calendar_month,
                            color: redColor,
                          ),
                          title: const Text('Janji Temu Dokter'),
                          subtitle: Text(closestJanjiTemu!.status ?? ''),
                          trailing: Text(Utils.formatDateJanjiTemu(
                              closestJanjiTemu!.date)),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              ProfileButtons(
                title: 'Riwayat',
                onPressed: () {
                  Get.toNamed(Routes.userRiwayat);
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pasien yang anda rawat mengalami keluhan?',
                    style: blackText.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomRedButton(
                    title: 'Laporkan Keluhan',
                    onPressed: () async {
                      print(adminPhoneNumber);
                      await launchUrlString(
                          mode: LaunchMode.externalApplication,
                          "https://wa.me/$adminPhoneNumber");
                    },
                  ),
                ],
              )
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: whiteColor,
        child: CustomRedButton(
          title: 'Keluar',
          onPressed: () async {
            auth.signOut();
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('user_type');
          },
        ),
      ),
    );
  }
}
