import 'package:cardi_care/model/materi_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/services/edukasi_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/Edukasi/materi_screen.dart';
import 'package:cardi_care/views/widgets/cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EdukasiScreen extends StatefulWidget {
  const EdukasiScreen({super.key});

  @override
  State<EdukasiScreen> createState() => _EdukasiScreenState();
}

class _EdukasiScreenState extends State<EdukasiScreen> {
  List<MateriModel> materiList = [];
  Map<String, bool> accessStatus = {}; // to track access status for each materi

  @override
  void initState() {
    super.initState();
    fetchMateri();
  }

  void fetchMateri() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
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
