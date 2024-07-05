import 'package:cardi_care/services/record_service.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

class RecordBulan extends StatefulWidget {
  const RecordBulan({super.key});

  @override
  State<RecordBulan> createState() => _RecordBulanState();
}

class _RecordBulanState extends State<RecordBulan> {
  Future<Map<String, int>> fetchCounts() async {
    try {
      int obatCount = await RecordService().countObatRecordsInLastMonth();
      int dietCount = await RecordService().countDietRecordsInLastMonth();
      int cairanCount = await RecordService().countCairanRecordsInLastMonth();
      int beratCount = await RecordService().countBeratRecordsInLastMonth();
      int olahragaCount =
          await RecordService().countOlahragaRecordsInLastMonth();
      int rokokCount = await RecordService().countRokokRecordsInLastMonth();

      return {
        'obatCount': obatCount,
        'dietCount': dietCount,
        'cairanCount': cairanCount,
        'beratCount': beratCount,
        'olahragaCount': olahragaCount,
        'rokokCount': rokokCount,
      };
    } catch (e) {
      throw Exception('Error fetching counts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: FutureBuilder<Map<String, int>>(
        future: fetchCounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final counts = snapshot.data!;
            return Column(
              children: [
                BarIndicator(
                  title: 'Konsumsi Obat',
                  calculate: counts['obatCount']! / 30,
                  total: '${counts['obatCount']}/30',
                ),
                BarIndicator(
                  title: 'Diet Rendah Garam',
                  calculate: counts['dietCount']! / 30,
                  total: '${counts['dietCount']}/30',
                ),
                BarIndicator(
                  title: 'Pembatasan Cairan',
                  calculate: counts['cairanCount']! / 30,
                  total: '${counts['cairanCount']}/30',
                ),
                BarIndicator(
                  title: 'Berat Badan',
                  calculate: counts['beratCount']! / 30,
                  total: '${counts['beratCount']}/30',
                ),
                BarIndicator(
                  title: 'Olahraga',
                  calculate: counts['olahragaCount']! / 30,
                  total: '${counts['olahragaCount']}/30',
                ),
                BarIndicator(
                  title: 'Merokok',
                  calculate: counts['rokokCount']! / 30,
                  total: '${counts['rokokCount']}/30',
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
