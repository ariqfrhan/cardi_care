import 'package:cardi_care/model/materi_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/services/edukasi_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/shared/utils.dart';
import 'package:cardi_care/views/widgets/cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EdukasiScreen extends StatefulWidget {
  const EdukasiScreen({super.key});

  @override
  State<EdukasiScreen> createState() => _EdukasiScreenState();
}

class _EdukasiScreenState extends State<EdukasiScreen> {
  List<MateriModel> materiList = [];
  Map<String, bool> accessStatus = {};
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    fetchMateri();
  }

  void fetchMateri() async {
    User? userId = auth.currentUser;
    List<MateriModel> materis = await EdukasiServices().getAllMateri();
    Map<String, bool> statusMap = {};

    for (var i = 0; i < materis.length; i++) {
      if (i == 0) {
        statusMap[materis[i].uid] = true;
      } else {
        bool hasCompletedPrevious = await EdukasiServices()
            .hasCompletedQuiz(userId!.uid, materis[i - 1].uid);
        statusMap[materis[i].uid] = hasCompletedPrevious;
      }
    }
    setState(() {
      materiList = materis;
      accessStatus = statusMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthServices auth = Get.find<AuthServices>();
    Future<dynamic> fetchUserData() async {
      String actor = await Utils.fetchActor();
      if (actor == "user") {
        return await auth.getUserData();
      } else if (actor == "keluarga") {
        return await auth.getKeluargaData();
      } else {
        throw Exception('Unknown user type');
      }
    }

    return Scaffold(
      body: FutureBuilder(
          future: fetchUserData(),
          builder: (context, snapshot) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(
                  height: 40,
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
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: materiList.length,
                    itemBuilder: (context, index) {
                      MateriModel materi = materiList[index];
                      bool isEnabled = accessStatus[materi.uid] ?? false;
                      return Column(
                        children: [
                          EducationCard(
                              nama: materi.nama,
                              enabled: isEnabled,
                              onTap: isEnabled
                                  ? () {
                                      Get.toNamed(Routes.userMateri,
                                          arguments: materi);
                                    }
                                  : null),
                          const SizedBox(
                            height: 12,
                          )
                        ],
                      );
                    }),
              ],
            );
          }),
    );
  }
}
