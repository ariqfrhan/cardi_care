import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

class RecordBulan extends StatelessWidget {
  const RecordBulan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: const Column(
        children: [
          BarIndicator(
            title: 'Konsumsi Obat',
            calculate: 0.1,
            total: '4/7',
          ),
          BarIndicator(
            title: 'Diet Rendah Garam',
            calculate: 0.20,
            total: '4/7',
          ),
          BarIndicator(
            title: 'Pembatasan Cairan',
            calculate: 0.57,
            total: '4/7',
          ),
          BarIndicator(
            title: 'Berat Badan',
            calculate: 0.57,
            total: '4/7',
          ),
          BarIndicator(
            title: 'Olahraga',
            calculate: 0.57,
            total: '4/7',
          ),
          BarIndicator(
            title: 'Merokok',
            calculate: 0.57,
            total: '4/7',
          ),
          BarIndicator(
            title: 'Konsumsi Alkohol',
            calculate: 0.57,
            total: '4/7',
          ),
        ],
      ),
    );
  }
}
