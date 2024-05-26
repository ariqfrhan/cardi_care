import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 64,
            ),
            Text(
              'Halo, Daiyan',
              style: blackText.copyWith(fontSize: 22, fontWeight: semibold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: pinkColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Tugas Harian',
                    style: blackText.copyWith(
                      fontSize: 18,
                      fontWeight: medium,
                    ),
                  ),
                  const FeatureButtons(
                    title: 'Olahraga',
                    icons: Icons.man,
                    status: false,
                  ),
                  const FeatureButtons(
                    title: 'Diet Rendah Garam',
                    icons: Icons.rice_bowl,
                    status: true,
                  ),
                  const FeatureButtons(
                    title: 'Konsumsi Obat',
                    icons: Icons.medication_outlined,
                    status: false,
                  ),
                  const FeatureButtons(
                    title: 'Berat Badan',
                    icons: Icons.monitor_weight,
                    status: false,
                  ),
                  const FeatureButtons(
                    title: 'Pembatasan Cairan',
                    icons: Icons.water,
                    status: false,
                  ),
                  const FeatureButtons(
                    title: 'Merokok & Alkohol',
                    icons: Icons.no_drinks,
                    status: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
