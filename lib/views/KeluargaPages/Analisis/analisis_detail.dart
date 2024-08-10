import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/services/keluarga_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/KeluargaPages/Analisis/analisis_detail_controller.dart';
import 'package:cardi_care/views/Record/record_bulan.dart';
import 'package:cardi_care/views/Record/record_hari.dart';
import 'package:cardi_care/views/Record/record_minggu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AnalisisDetail extends StatefulWidget {
  const AnalisisDetail({super.key});

  @override
  State<AnalisisDetail> createState() => _AnalisisDetailState();
}

class _AnalisisDetailState extends State<AnalisisDetail> {
  final AnalisisDetailController controller =
      Get.put(AnalisisDetailController());
  final AuthServices auth = Get.find<AuthServices>();
  final KeluargaServices keluargaServices = KeluargaServices();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetchFirstUser();
  }

  void fetchFirstUser() async {
    String familyId = await auth.getKeluargaData().then((value) => value.uid);
    UserModel? fetchedUser =
        await keluargaServices.getFirstUserByKeluargaId(familyId);
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          user!.name,
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: pinkColor),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _upperAppBar(context, page: 0, label: 'Hari'),
                  _upperAppBar(context, page: 1, label: 'Minggu'),
                  _upperAppBar(context, page: 2, label: 'Bulan'),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.animateToTab,
              physics: const BouncingScrollPhysics(),
              children: [
                RecordHari(user: user!),
                RecordMinggu(user: user!),
                RecordBulan(user: user!),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _upperAppBar(
    BuildContext context, {
    required int page,
    required String label,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: controller.currentPage.value == page
            ? Border(
                bottom: BorderSide(
                color: redColor,
                width: 2,
              ))
            : const Border(),
      ),
      child: ZoomTapAnimation(
        onTap: () => controller.goToTab(page),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    controller.currentPage.value == page ? bold : regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
