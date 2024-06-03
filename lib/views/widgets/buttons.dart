import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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

class FeatureButtons extends StatelessWidget {
  final String title;
  final IconData icons;
  final bool status;
  final VoidCallback? onPressed;

  const FeatureButtons({
    super.key,
    required this.title,
    required this.icons,
    this.status = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: redColor, borderRadius: BorderRadius.circular(100)),
              width: 32, // Misalnya, menentukan lebar ikon secara eksplisit
              height: 32, // Dan tinggi ikon
              child: Icon(
                icons,
                color: whiteColor, // Mengubah warna ikon
                size: 24, // Mengatur ukuran ikon
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: blackText.copyWith(
                  fontWeight: bold,
                  fontSize: 14,
                ),
              ),
            ),
            status == false
                ? Container(
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.add,
                      color: whiteColor,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.check,
                      color: whiteColor,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class ProfileButtons extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const ProfileButtons({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: pinkColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: redText.copyWith(
                  fontWeight: bold,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}
