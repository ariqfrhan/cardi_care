import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final bool obscureText;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hint;
  final Function(String)? onFieldSubmitted;

  const CustomFormField(
      {super.key,
      required this.title,
      this.obscureText = false,
      this.isShowTitle = true,
      this.keyboardType,
      this.controller,
      this.hint,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // isShowTitle
        //     ? Text(
        //         title,
        //         style: blackText.copyWith(fontWeight: medium),
        //       )
        //     : const SizedBox(
        //         height: 0,
        //       ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
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
