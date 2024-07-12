import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/services/record_service.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

class RecordBulan extends StatefulWidget {
  final UserModel? user;
  const RecordBulan({super.key, this.user});

  @override
  State<RecordBulan> createState() => _RecordBulanState();
}

class _RecordBulanState extends State<RecordBulan> {
  Future<Map<String, int>> fetchCounts() async {
    try {
      int obatCount = await RecordService()
          .countObatRecordsInLastMonth(userModel: widget.user);
      int dietCount = await RecordService()
          .countDietRecordsInLastMonth(userModel: widget.user);
      int cairanCount = await RecordService()
          .countCairanRecordsInLastMonth(userModel: widget.user);
      int beratCount = await RecordService()
          .countBeratRecordsInLastMonth(userModel: widget.user);
      int olahragaCount = await RecordService()
          .countOlahragaRecordsInLastMonth(userModel: widget.user);
      int rokokCount = await RecordService()
          .countRokokRecordsInLastMonth(userModel: widget.user);
      int userObat = await RecordService().countObat(userModel: widget.user);

      return {
        'obatCount': obatCount,
        'dietCount': dietCount,
        'cairanCount': cairanCount,
        'beratCount': beratCount,
        'olahragaCount': olahragaCount,
        'rokokCount': rokokCount,
        'userObat': userObat
      };
    } catch (e) {
      throw Exception('Error fetching counts: $e');
    }
  }

  double calculateProgress(int count, double total) {
    return total > 0 ? count / total : 0;
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
            double obatProgress = counts['userObat']! > 0
                ? (counts['obatCount']! / counts['userObat']!) / 30
                : 0;
            return Column(
              children: [
                BarIndicator(
                  title: 'Konsumsi Obat',
                  calculate: double.parse(obatProgress.toStringAsFixed(1)),
                  total: '${(counts['obatCount']! / counts['userObat']!)} / 30',
                ),
                BarIndicator(
                  title: 'Diet Rendah Garam',
                  calculate: double.parse(
                      calculateProgress(counts['dietCount']!, 30)
                          .toStringAsFixed(1)),
                  total: '${counts['dietCount']}/30',
                ),
                BarIndicator(
                  title: 'Pembatasan Cairan',
                  calculate: double.parse(
                      calculateProgress(counts['cairanCount']!, 30)
                          .toStringAsFixed(1)),
                  total: '${counts['cairanCount']}/30',
                ),
                BarIndicator(
                  title: 'Berat Badan',
                  calculate: double.parse(
                      calculateProgress(counts['beratCount']!, 30)
                          .toStringAsFixed(1)),
                  total: '${counts['beratCount']}/30',
                ),
                BarIndicator(
                  title: 'Olahraga',
                  calculate: double.parse(
                      calculateProgress(counts['olahragaCount']!, 30)
                          .toStringAsFixed(1)),
                  total: '${counts['olahragaCount']}/30',
                ),
                BarIndicator(
                  title: 'Merokok',
                  calculate: double.parse(
                      calculateProgress(counts['rokokCount']!, 30)
                          .toStringAsFixed(1)),
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
