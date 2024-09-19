import 'dart:io';

import 'package:cardi_care/routes.dart';
import 'package:cardi_care/views/TekaTekiSilang/services/tts_service.dart';
import 'package:cardi_care/views/TekaTekiSilang/types/item_datas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../providers.dart';

class TekaTekiSilangQuestion extends ConsumerStatefulWidget {
  const TekaTekiSilangQuestion({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<TekaTekiSilangQuestion> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(ttsNotifierProvider.notifier).getLoading();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.5,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          if (isLoading) loadingIndicator(),
          if (!isLoading) questionList(),
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width - 35,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget questionList() {
    final ttsProvider = ref.watch(ttsNotifierProvider.notifier);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Pertanyaan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Pertanyaan Menurun',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            verticalQuestionList(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Pertanyaan Mendatar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            horizontalQuestionList(),
            const SizedBox(height: 20),
            if (!ttsProvider.isClear()) saveButton(),
          ],
        ),
      ),
    );
  }

  Widget verticalQuestionList() {
    List<String> verticalQuestion =
        ref.watch(ttsNotifierProvider.notifier).getVerticalQuestion();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Text(verticalQuestion[index]);
      },
      itemCount: verticalQuestion.length,
    );
  }

  Widget horizontalQuestionList() {
    List<String> horizontalQuestion =
        ref.watch(ttsNotifierProvider.notifier).getHorizontalQuestion();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Text(horizontalQuestion[index]);
      },
      itemCount: horizontalQuestion.length,
    );
  }

  Widget saveButton() {
    final ttsProvider = ref.watch(ttsNotifierProvider.notifier);

    return ElevatedButton.icon(
      onPressed: saveProcess,
      icon: ttsProvider.getSavingStatus() == true
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : const Icon(Icons.save),
      label: const Text('Simpan'),
      iconAlignment: IconAlignment.start,
    );
  }

  void saveProcess() async {
    final ttsProvider = ref.watch(ttsNotifierProvider.notifier);
    final String meteriId = ttsProvider.getTtsMateriId();
    User? userId = auth.currentUser;
    final List<ItemDatas> items = ttsProvider.getStateItems();
    ttsProvider.isSaving(true);
    final res = await TtsService().saveQuizResult(userId!.uid, meteriId, items);

    ttsProvider.isSaving(false);

    if (res) Get.toNamed(Routes.userEdukasi);
  }
}
