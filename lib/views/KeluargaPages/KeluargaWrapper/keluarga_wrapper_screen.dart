import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/Edukasi/edukasi_screen.dart';
import 'package:cardi_care/views/KeluargaPages/Analisis/analisis_detail.dart';
import 'package:cardi_care/views/KeluargaPages/Keluarga%20Profile/keluarga_profile.dart';
import 'package:cardi_care/views/KeluargaPages/KeluargaWrapper/keluarga_wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class KeluargaWrapperScreen extends StatelessWidget {
  KeluargaWrapperScreen({super.key});

  final KeluargaWrapperController controller =
      Get.put(KeluargaWrapperController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.animateToTab,
        physics: const BouncingScrollPhysics(),
        children: const [
          EdukasiScreen(),
          AnalisisDetail(),
          KeluargaProfile(),
        ],
      ),
      bottomNavigationBar: Obx(() => BottomAppBar(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBar(
                    context,
                    icon: Icons.menu_book,
                    page: 0,
                    label: 'Edukasi',
                  ),
                  _bottomAppBar(
                    context,
                    icon: Icons.bar_chart,
                    page: 1,
                    label: 'Akumulasi',
                  ),
                  _bottomAppBar(
                    context,
                    icon: Icons.person,
                    page: 2,
                    label: 'Profil',
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _bottomAppBar(
    BuildContext context, {
    required IconData icon,
    required page,
    required String label,
  }) {
    return ZoomTapAnimation(
        onTap: () => controller.goToTab(page),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:
                  controller.currentPage.value == page ? redColor : Colors.grey,
            ),
            Text(
              label,
            )
          ],
        ));
  }
}
