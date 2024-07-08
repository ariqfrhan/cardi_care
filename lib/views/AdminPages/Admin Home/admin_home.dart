import 'package:cardi_care/services/Admin_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      return await AdminServices().fetchUsersWithoutSelfCare();
    } catch (e) {
      throw Exception('Error fetching status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 64,
                ),
                Text(
                  'Peringatan',
                  style: blackText.copyWith(fontSize: 22, fontWeight: semibold),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      final usersWithoutSelfCare = snapshot.data!;
                      if (usersWithoutSelfCare.isEmpty) {
                        return const Center(
                          child:
                              Text('Semua pengguna telah melakukan self-care'),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Hari ini',
                            style: blackText.copyWith(
                              fontSize: 18,
                              fontWeight: medium,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          for (var entry in usersWithoutSelfCare)
                            Column(
                              children: [
                                ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  tileColor: pinkColor,
                                  title: Text(
                                    entry['user'].name,
                                    style: blackText.copyWith(
                                        fontSize: 16, fontWeight: bold),
                                  ),
                                  subtitle: Text(
                                    entry['daysSinceLastSelfCare'] != null
                                        ? '${entry['user'].name} tidak melakukan self-care selama ${entry['daysSinceLastSelfCare']} hari'
                                        : '${entry['user'].name} belum pernah melakukan self-care',
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  visualDensity:
                                      const VisualDensity(vertical: 3),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
