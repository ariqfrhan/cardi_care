import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Alarm extends StatelessWidget {
  const Alarm({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    String dateNow = Utils.convertToDayFormat(date);
    String hourNow = Utils.convertToHourFormat(date);
    String timeNow = Utils.getWaktu(date);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dateNow,
              style: blackText.copyWith(fontSize: 12, color: mono600),
            ),
            Text(hourNow,
                style: blackText.copyWith(
                  fontSize: 64,
                  fontWeight: extraBold,
                )),
            Container(
              height: 361,
              width: 361,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/alarm.png'),
                ),
              ),
            ),
            Text(
              'Yuk konsumsi obat $timeNow!',
              style: redText.copyWith(fontSize: 22, fontWeight: semibold),
            ),
            Text(
              'Waktunya untuk mengkonsumsi obat $timeNow, jangan sampai telat yaa!',
              style: blackText.copyWith(
                fontWeight: semibold,
                color: mono600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 36,
            ),
            ZoomTapAnimation(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 150,
                height: 52,
                decoration: BoxDecoration(
                  color: pinkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'X',
                      style:
                          redText.copyWith(fontSize: 22, fontWeight: semibold),
                    ),
                    Text(
                      'Selesai',
                      style:
                          redText.copyWith(fontSize: 22, fontWeight: semibold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
