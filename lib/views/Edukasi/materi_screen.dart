import 'package:cardi_care/model/materi_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class Materi extends StatefulWidget {
  const Materi({super.key});

  @override
  State<Materi> createState() => _MateriState();
}

class _MateriState extends State<Materi> {
  final MateriModel materi = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        foregroundColor: red950,
        title: Text(
          'Edukasi',
          style: blackText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 8),
          Text(
            'Tema',
            style: blackText.copyWith(
                fontSize: 14, fontWeight: bold, color: redColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  materi.nama,
                  style: blackText.copyWith(fontSize: 22, fontWeight: bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Html(data: materi.materi),
          ),
          if (materi.uid == 'materi3') ...[
            const VideoPlayer(
                videoPath: "assets/edukasi/materi3/diet_garam_dan_cairan.mp4"),
            const SizedBox(height: 20),
            const VideoPlayer(videoPath: "assets/edukasi/materi3/napas_dalam.mp4"),
          ] else if (materi.uid == 'materi4') ...[
            const VideoPlayer(
                videoPath: "assets/edukasi/materi4/six_minute_walk.mp4"),
          ],
          // Tambahkan padding di bawah untuk memberikan ruang pada konten scroll
          const SizedBox(height: 100),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomRedButton(
                  title: 'TTS',
                  onPressed: () {
                    Get.toNamed(Routes.tekaTekiSilang, arguments: materi);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomRedButton(
                  title: 'Quiz',
                  onPressed: () {
                    Get.toNamed(Routes.userQuiz, arguments: materi);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
