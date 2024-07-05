import 'package:cardi_care/services/record_service.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

class RecordHari extends StatefulWidget {
  const RecordHari({super.key});

  @override
  State<RecordHari> createState() => _RecordHariState();
}

class _RecordHariState extends State<RecordHari> {
  Future<Map<String, int>> fetchCounts() async {
    try {
      int obatCount = await RecordService().countObatRecordsInLastDay();
      int dietCount = await RecordService().countDietRecordsInLastDay();
      int cairanCount = await RecordService().countCairanRecordsInLastDay();
      int beratCount = await RecordService().countBeratRecordsInLastDay();
      int olahragaCount = await RecordService().countOlahragaRecordsInLastDay();
      int rokokCount = await RecordService().countRokokRecordsInLastDay();

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
                  calculate: counts['obatCount']! / 1,
                  total: '${counts['obatCount']}/1',
                ),
                BarIndicator(
                  title: 'Diet Rendah Garam',
                  calculate: counts['dietCount']! / 1,
                  total: '${counts['dietCount']}/1',
                ),
                BarIndicator(
                  title: 'Pembatasan Cairan',
                  calculate: counts['cairanCount']! / 1,
                  total: '${counts['cairanCount']}/1',
                ),
                BarIndicator(
                  title: 'Berat Badan',
                  calculate: counts['beratCount']! / 1,
                  total: '${counts['beratCount']}/1',
                ),
                BarIndicator(
                  title: 'Olahraga',
                  calculate: counts['olahragaCount']! / 1,
                  total: '${counts['olahragaCount']}/1',
                ),
                BarIndicator(
                  title: 'Merokok',
                  calculate: counts['rokokCount']! / 1,
                  total: '${counts['rokokCount']}/1',
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
