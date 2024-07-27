import 'package:cardi_care/model/janji_temu_model.dart';
import 'package:cardi_care/model/obat_model.dart';
import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/tugas_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/shared/utils.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AdminObatDetail extends StatefulWidget {
  const AdminObatDetail({super.key});

  @override
  State<AdminObatDetail> createState() => _AdminObatDetailState();
}

class _AdminObatDetailState extends State<AdminObatDetail> {
  final UserModel user = Get.arguments;
  List<ObatModel> obatList = [];
  List<JanjiTemuModel> janjiList = [];

  @override
  void initState() {
    fetchObat();
    fetchJanji();
    super.initState();
  }

  void fetchObat() async {
    List<ObatModel> obats = await TugasServices().getObatDataByUserId(user.uid);
    setState(() {
      obatList = obats;
    });
  }

  void fetchJanji() async {
    List<JanjiTemuModel> janjis =
        await TugasServices().getJanjiTemuByUserId(user.uid);
    setState(() {
      janjiList = janjis;
    });
  }

  void showEditDeleteDialog(BuildContext context, ObatModel obat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(obat.nama),
          content: const Text('Edit atau hapus obat?'),
          actions: <Widget>[
            TextButton(
              child: Container(
                width: 95,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: redColor)),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.edit,
                        color: redColor,
                      ),
                    ),
                    Expanded(
                        child: Text(
                      'Edit',
                      style: redText,
                    ))
                  ],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Get.offNamed(Routes.adminEditDetail, arguments: [user, obat]);
              },
            ),
            TextButton(
              child: Container(
                width: 110,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: redColor)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.delete,
                        color: whiteColor,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Delete',
                          style: whiteText,
                        ))
                  ],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                TugasServices().deleteObat(obat.id);
                fetchObat();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        leading: ZoomTapAnimation(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
        title: Text(
          user.name,
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      backgroundColor: pinkColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Janji Temu',
                      style: blackText.copyWith(fontSize: 22, fontWeight: bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomRedButton(
                      width: 48,
                      height: 48,
                      title: 'Tambah Janji',
                      fontSize: 12,
                      onPressed: () {
                        Get.toNamed(Routes.adminTambahJanji, arguments: user);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: janjiList.length,
                  itemBuilder: (context, index) {
                    JanjiTemuModel janji = janjiList[index];
                    String date = Utils.formatDateJanjiTemu(janji.date);
                    return Column(
                      children: [
                        JanjiTile(
                          notes: janji.status,
                          time: date,
                        ),
                        const SizedBox(
                          height: 12,
                        )
                      ],
                    );
                  }),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Daftar Obat',
                style: blackText.copyWith(fontSize: 22, fontWeight: bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: obatList.length,
                  itemBuilder: (context, index) {
                    ObatModel obat = obatList[index];
                    String waktu = Utils.getWaktu(obat.date);
                    return Column(
                      children: [
                        ObatListTile(
                          name: obat.nama,
                          time: waktu,
                          onTap: () {
                            showEditDeleteDialog(context, obat);
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        )
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: whiteColor,
        foregroundColor: redColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: () {
          Get.offNamed(Routes.adminTambahDetail, arguments: user);
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Obat'),
      ),
    );
  }
}
