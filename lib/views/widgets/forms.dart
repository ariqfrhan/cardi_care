import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final bool obscureText;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hint;
  final String? suffixText;
  final Function(String)? onFieldSubmitted;

  const CustomFormField(
      {super.key,
      required this.title,
      this.obscureText = false,
      this.isShowTitle = false,
      this.keyboardType,
      this.controller,
      this.hint,
      this.onFieldSubmitted,
      this.suffixText = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isShowTitle
            ? Text(
                title,
                style: blackText.copyWith(fontWeight: medium),
              )
            : const SizedBox(
                height: 0,
              ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffix: Text(suffixText!),
            labelText: title,
            focusColor: redColor,
            floatingLabelStyle: TextStyle(color: redColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.all(12),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: redColor),
            ),
          ),
        ),
      ],
    );
  }
}

class ObatForms extends StatefulWidget {
  final String namaObat;
  final int jam;
  final Function(String?) onOptionChanged;

  const ObatForms(
      {super.key,
      required this.namaObat,
      required this.jam,
      required this.onOptionChanged});

  @override
  State<ObatForms> createState() => _ObatFormsState();
}

class _ObatFormsState extends State<ObatForms> {
  late TextEditingController dateCtl = TextEditingController();
  String? selectedOptions;
  List<String> options = [
    'Belum',
    'Mandiri',
    'Keluarga mengingatkan\ndan memastikan obat\nsesuai anjuran'
  ];

  @override
  void initState() {
    super.initState();
    dateCtl = TextEditingController();
    selectedOptions = options[0];
  }

  @override
  void dispose() {
    super.dispose();
    dateCtl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: pinkColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              widget.namaObat,
              style: blackText.copyWith(fontWeight: bold),
              maxLines: 1, // Membatasi teks hanya pada satu baris
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: redColor,
                floatingLabelStyle: TextStyle(
                  color: redColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: redColor,
                  ),
                ),
              ),
              iconEnabledColor: whiteColor,
              dropdownColor: redColor,
              value: selectedOptions,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOptions = newValue;
                });
                widget.onOptionChanged(newValue);
              },
              items: options.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: whiteText.copyWith(fontSize: 13, fontWeight: bold),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
