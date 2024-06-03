import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DietView extends StatefulWidget {
  const DietView({super.key});

  @override
  State<DietView> createState() => _DietViewState();
}

class _DietViewState extends State<DietView> {
  late TextEditingController dateCtl = TextEditingController();
  String? selectedOption;

  List<String> options = ['Berat', 'Ringan', 'Sedang'];

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
          'Diet Garam Rendah',
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
              'Kenapa diet garam rendah penting?',
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
            Text(
              'Dietku',
              style: blackText.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: dateCtl,
              decoration: InputDecoration(
                filled: true,
                fillColor: pinkColor,
                labelText: 'Tanggal',
                suffixIcon: const Icon(Icons.date_range),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: redColor,
                  ),
                ),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime now = DateTime.now();
                DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: now.subtract(const Duration(days: 7)),
                  firstDate: now
                      .subtract(const Duration(days: 7)), // Seminggu yang lalu
                  lastDate: now,
                );
                if (dateTime != null) {
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(dateTime);
                  setState(() {
                    dateCtl.text = formattedDate;
                  });
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: pinkColor,
                floatingLabelStyle: TextStyle(color: redColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: redColor)),
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sendok teh',
                      style: blackText.copyWith(fontSize: 12, fontWeight: bold),
                    ),
                  ],
                ),
                labelText: 'Jumlah Garam',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Foto',
              style: blackText.copyWith(
                fontSize: 14,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: pinkColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('Dokumentasikan aktivitas dietmu'),
              ),
            ),
            const SizedBox(
              height: 4,
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
