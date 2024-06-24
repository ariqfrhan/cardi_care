import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/forms.dart';
import 'package:flutter/material.dart';

class ObatView extends StatefulWidget {
  const ObatView({super.key});

  @override
  State<ObatView> createState() => _ObatViewState();
}

class _ObatViewState extends State<ObatView> {
  late TextEditingController dateCtl = TextEditingController();
  String? selectedOptionObat;

  List<String> options = [
    'Ya',
    'Tidak',
  ];

  final List<Map<String, dynamic>> obatData = [
    {'nama': 'Obat A', 'jam': 8},
    {'nama': 'Obat B', 'jam': 13},
    {'nama': 'Obat X', 'jam': 14},
    {'nama': 'Obat C', 'jam': 19},
    {'nama': 'Obat Z', 'jam': 9},
  ];

  @override
  void initState() {
    super.initState();
    dateCtl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    dateCtl.dispose();
  }

  void _handleOptionChanged(String? newValue) {
    setState(() {
      selectedOptionObat = newValue;
    });
  }

  List<Widget> _buildObatForms(
      List<Map<String, dynamic>> data, int startHour, int endHour) {
    return data
        .where((obat) => obat['jam'] >= startHour && obat['jam'] <= endHour)
        .map((obat) => ObatForms(
              namaObat: obat['nama'],
              jam: obat['jam'],
              onOptionChanged: _handleOptionChanged,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          'Meminum Obat',
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kenapa obat penting?',
                    style: blackText.copyWith(
                      fontSize: 18,
                      fontWeight: semibold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna.',
                    style: blackText.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Pagi (06.00-10.00)',
                      style: blackText.copyWith(fontSize: 16, fontWeight: bold),
                    ),
                  ),
                  ..._buildObatForms(obatData, 6, 10),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Siang (12.00-15.00)',
                      style: blackText.copyWith(fontSize: 16, fontWeight: bold),
                    ),
                  ),
                  ..._buildObatForms(obatData, 12, 15),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Malam (18.00-20.00)',
                      style: blackText.copyWith(fontSize: 16, fontWeight: bold),
                    ),
                  ),
                  ..._buildObatForms(obatData, 18, 20),
                ],
              ),
            ],
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomRedButton(
          title: 'Simpan',
          onPressed: () {},
        ),
      ),
    );
  }
}
