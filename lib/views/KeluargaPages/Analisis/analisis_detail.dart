import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/KeluargaPages/Analisis/analisis_detail_controller.dart';
import 'package:cardi_care/views/Record/record_bulan.dart';
import 'package:cardi_care/views/Record/record_hari.dart';
import 'package:cardi_care/views/Record/record_minggu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AnalisisDetail extends StatelessWidget {
  AnalisisDetail({super.key});

  final AnalisisDetailController controller =
      Get.put(AnalisisDetailController());

  @override
  Widget build(BuildContext context) {
    final UserModel user = Get.arguments;

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
              )),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.animateToTab,
              physics: const BouncingScrollPhysics(),
              children: [
                RecordHari(
                  user: user,
                ),
                RecordMinggu(
                  user: user,
                ),
                RecordBulan(
                  user: user,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _upperAppBar(
    BuildContext context, {
    required int page, // Use int for page index
    required String label,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: controller.currentPage.value == page
            ? Border(
                bottom: BorderSide(
                color: redColor,
                width: 2,
              )) // Adjust underline style
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
                fontWeight: controller.currentPage.value == page
                    ? bold
                    : regular, // Assuming blackText is a Color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
