import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MerokokAlkoholView extends StatefulWidget {
  const MerokokAlkoholView({super.key});

  @override
  State<MerokokAlkoholView> createState() => _MerokokAlkoholViewState();
}

class _MerokokAlkoholViewState extends State<MerokokAlkoholView> {
  late TextEditingController dateCtl = TextEditingController();
  String? selectedOptionRokok;
  String? selectedOptionAlkohol;

  List<String> options = [
    'Ya',
    'Tidak',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          'Merokok & Alkohol',
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kenapa alkohol penting?',
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
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 8,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Apakah hari ini anda merokok?',
                filled: true,
                fillColor: pinkColor,
                floatingLabelStyle: TextStyle(
                  color: redColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: redColor,
                  ),
                ),
              ),
              value: selectedOptionRokok,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOptionRokok = newValue;
                });
              },
              items: options.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            const SizedBox(
              height: 8,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Apakah hari ini anda mengonsumsi alkohol?',
                filled: true,
                fillColor: pinkColor,
                floatingLabelStyle: TextStyle(
                  color: redColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: redColor,
                  ),
                ),
              ),
              value: selectedOptionAlkohol,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOptionAlkohol = newValue;
                });
              },
              items: options.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
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
