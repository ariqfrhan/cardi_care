import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomRedButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomRedButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 50,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: () {
            onPressed?.call();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: redColor,
              foregroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            title,
            style: whiteText.copyWith(fontSize: 16, fontWeight: semibold),
          )),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomOutlineButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 50,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: () {
            onPressed?.call();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: whiteColor,
              side: BorderSide(color: redColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            title,
            style: whiteText.copyWith(fontSize: 16, fontWeight: semibold),
          )),
    );
  }
}
