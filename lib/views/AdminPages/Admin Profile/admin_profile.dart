import 'package:cardi_care/model/AdminModel/admin_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServices auth = Get.find<AuthServices>();

    return Scaffold(
      body: FutureBuilder(
        future: auth.getAdminData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data found'));
          }

          AdminModel user = snapshot.data!;

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
              const SizedBox(height: 64),
              const ProfileButtons(title: 'Pengaturan'),
              // ProfileButtons(
              //   title: 'Riwayat',
              //   onPressed: () {
              //     Get.toNamed(Routes.userRiwayat);
              //   },
              // ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: whiteColor,
        child: CustomRedButton(
          title: 'Keluar',
          onPressed: () {
            auth.signOut();
          },
        ),
      ),
    );
  }
}
