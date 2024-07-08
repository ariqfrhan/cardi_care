import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/AdminPages/Admin%20Analisis/admin_analisis_home.dart';
import 'package:cardi_care/views/AdminPages/Admin%20Home/admin_home.dart';
import 'package:cardi_care/views/AdminPages/Admin%20Profile/admin_profile.dart';
import 'package:cardi_care/views/AdminPages/Admin%20Tambah%20Obat/admin_tambah_obat.dart';
import 'package:cardi_care/views/KeluargaPages/KeluargaWrapper/keluarga_wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AdminWrapperScreen extends StatelessWidget {
  AdminWrapperScreen({super.key});

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
          AdminHome(),
          AdminAnalisisHome(),
          AdminTambahObatHome(),
          AdminProfile(),
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
                    icon: Icons.warning_rounded,
                    page: 0,
                    label: 'Peringatan',
                  ),
                  _bottomAppBar(
                    context,
                    icon: Icons.bar_chart,
                    page: 1,
                    label: 'Analisis',
                  ),
                  _bottomAppBar(
                    context,
                    icon: Icons.medical_information,
                    page: 2,
                    label: 'Obat',
                  ),
                  _bottomAppBar(
                    context,
                    icon: Icons.person,
                    page: 3,
                    label: 'Profile',
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
