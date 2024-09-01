import 'dart:async';
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
  Duration? nextMateriCountdown;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final EdukasiServices _edukasiServices = EdukasiServices();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchMateri();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (nextMateriCountdown != null &&
            nextMateriCountdown! > Duration.zero) {
          nextMateriCountdown = nextMateriCountdown! - Duration(seconds: 1);
        } else if (nextMateriCountdown != null &&
            nextMateriCountdown! <= Duration.zero) {
          // Refresh materi list when countdown reaches zero
          fetchMateri();
        }
      });
    });
  }

  Future<bool> canAccessMateri(String userId, String materiId,
      String? previousMateriId, String? nextMateriId) async {
    if (previousMateriId == null) {
      return true;
    }

    bool hasAccessedNext = nextMateriId != null
        ? await _edukasiServices.hasAccessedBefore(userId, nextMateriId)
        : false;

    if (hasAccessedNext) {
      return true;
    }

    bool hasCompletedPrevious =
        await _edukasiServices.hasCompletedQuiz(userId, previousMateriId);
    if (!hasCompletedPrevious) return false;

    DateTime? lastCompletionTime = await _edukasiServices
        .getLastQuizCompletionTime(userId, previousMateriId);
    if (lastCompletionTime == null) return false;

    Duration timeSinceCompletion =
        DateTime.now().difference(lastCompletionTime);
    Duration remainingTime = Duration(hours: 24) - timeSinceCompletion;

    if (remainingTime > Duration.zero) {
      if (nextMateriCountdown == null || remainingTime < nextMateriCountdown!) {
        nextMateriCountdown = remainingTime;
      }
      return false;
    }
    return true;
  }

  void fetchMateri() async {
    User? user = auth.currentUser;
    if (user == null) return;

    List<MateriModel> materis = await _edukasiServices.getAllMateri();
    Map<String, bool> statusMap = {};
    nextMateriCountdown = null;

    for (var i = 0; i < materis.length; i++) {
      String? previousMateriId = i > 0 ? materis[i - 1].uid : null;
      String? nextMateriId = i < materis.length - 1 ? materis[i + 1].uid : null;
      bool canAccess = await canAccessMateri(
          user.uid, materis[i].uid, previousMateriId, nextMateriId);
      statusMap[materis[i].uid] = canAccess;
      if (!canAccess) break; // Stop checking once we find a locked materi
    }

    setState(() {
      materiList = materis;
      accessStatus = statusMap;
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 40),
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
          const SizedBox(height: 12),
          if (nextMateriCountdown != null)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Materi selanjutnya dapat diakses dalam: ${formatDuration(nextMateriCountdown!)}',
                style: whiteText.copyWith(fontWeight: bold),
                textAlign: TextAlign.center,
              ),
            ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
                              Get.toNamed(Routes.userMateri, arguments: materi);
                            }
                          : null,
                    ),
                    const SizedBox(height: 12)
                  ],
                );
              }),
        ],
      ),
    );
  }
}
