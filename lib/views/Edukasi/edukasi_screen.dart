import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EdukasiScreen extends StatelessWidget {
  const EdukasiScreen({super.key});

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
                Container(
                    decoration: BoxDecoration(
                      color: red100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu_book,
                            size: 24,
                            color: red950,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tema',
                                style: blackText.copyWith(
                                    fontSize: 12, color: redColor),
                              ),
                              Text(
                                'Seputar Gagal Jantung',
                                style: blackText.copyWith(
                                    fontSize: 16, fontWeight: bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 12,
                ),
                // Locked Material
                Container(
                    decoration: BoxDecoration(
                      color: mono150,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock,
                            size: 24,
                            color: mono600,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tema',
                                style: blackText.copyWith(
                                    fontSize: 12, color: mono600),
                              ),
                              Text(
                                'Seputar Gagal Jantung',
                                style: blackText.copyWith(
                                    fontSize: 16,
                                    fontWeight: bold,
                                    color: mono600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            );
          }),
    );
  }
}
