import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final AuthServices auth = Get.find<AuthServices>();
  int _soal1 = 0;
  int _soal2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        foregroundColor: red950,
        title: Text(
          'Quiz',
          style: blackText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
        centerTitle: true,
      ),
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
                  height: 8,
                ),
                Text(
                  'Tema',
                  style: blackText.copyWith(
                      fontSize: 14, fontWeight: bold, color: redColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Seputar Gagal Jantung',
                      style: blackText.copyWith(fontSize: 22, fontWeight: bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '5 Pertanyaan',
                  style: blackText.copyWith(
                      fontSize: 14, fontWeight: bold, color: mono600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1',
                          style: blackText.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                            width:
                                8), // Add some spacing between the number and the text
                        Flexible(
                          child: Text(
                            'Apa yang dimaksud dengan penyakit gagal jantung?',
                            style: blackText.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _soal1,
                              onChanged: (int? value) {
                                setState(() {
                                  _soal1 = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                'Penyakit yang disebabkan oleh kelemahan otot',
                                style: blackText.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: _soal1,
                              onChanged: (int? value) {
                                setState(() {
                                  _soal1 = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                'Penyakit akibat peradangan',
                                style: blackText.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 3,
                              groupValue: _soal1,
                              onChanged: (int? value) {
                                setState(() {
                                  _soal1 = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                'Kelainan struktur atau fungsi jantung',
                                style: blackText.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2',
                          style: blackText.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                            width:
                                8), // Add some spacing between the number and the text
                        Flexible(
                          child: Text(
                            'Apa yang dimaksud dengan penyakit gagal jantung?',
                            style: blackText.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _soal2,
                              onChanged: (int? value) {
                                setState(() {
                                  _soal2 = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                'Penyakit yang disebabkan oleh kelemahan otot',
                                style: blackText.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: _soal2,
                              onChanged: (int? value) {
                                setState(() {
                                  _soal2 = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                'Penyakit akibat peradangan',
                                style: blackText.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 3,
                              groupValue: _soal2,
                              onChanged: (int? value) {
                                setState(() {
                                  _soal2 = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                'Kelainan struktur atau fungsi jantung',
                                style: blackText.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Text('Harap jawab semua pertanyaan!'),
                BottomAppBar(
                  color: whiteColor,
                  child: CustomRedButton(
                    title: 'Simpan',
                    onPressed: () {},
                  ),
                ),
              ],
            );
          }),
    );
  }
}
