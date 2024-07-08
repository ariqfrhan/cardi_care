import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/services/record_service.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

class RecordMinggu extends StatefulWidget {
  final UserModel? user;
  const RecordMinggu({super.key, this.user});

  @override
  State<RecordMinggu> createState() => _RecordMingguState();
}

class _RecordMingguState extends State<RecordMinggu> {
  Future<Map<String, int>> fetchCounts() async {
    try {
      int obatCount = await RecordService()
          .countObatRecordsInLastWeek(userModel: widget.user);
      int dietCount = await RecordService()
          .countDietRecordsInLastWeek(userModel: widget.user);
      int cairanCount = await RecordService()
          .countCairanRecordsInLastWeek(userModel: widget.user);
      int beratCount = await RecordService()
          .countBeratRecordsInLastWeek(userModel: widget.user);
      int olahragaCount = await RecordService()
          .countOlahragaRecordsInLastWeek(userModel: widget.user);
      int rokokCount = await RecordService()
          .countRokokRecordsInLastWeek(userModel: widget.user);
      int userObat = await RecordService().countObat(userModel: widget.user);

      return {
        'obatCount': obatCount,
        'dietCount': dietCount,
        'cairanCount': cairanCount,
        'beratCount': beratCount,
        'olahragaCount': olahragaCount,
        'rokokCount': rokokCount,
        'userObat': userObat,
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
                  calculate: (counts['obatCount']! / counts['userObat']!) / 7,
                  total: '${(counts['obatCount']! / counts['userObat']!)}/7',
                ),
                BarIndicator(
                  title: 'Diet Rendah Garam',
                  calculate: counts['dietCount']! / 7,
                  total: '${counts['dietCount']}/7',
                ),
                BarIndicator(
                  title: 'Pembatasan Cairan',
                  calculate: counts['cairanCount']! / 7,
                  total: '${counts['cairanCount']}/7',
                ),
                BarIndicator(
                  title: 'Berat Badan',
                  calculate: counts['beratCount']! / 7,
                  total: '${counts['beratCount']}/7',
                ),
                BarIndicator(
                  title: 'Olahraga',
                  calculate: counts['olahragaCount']! / 7,
                  total: '${counts['olahragaCount']}/7',
                ),
                BarIndicator(
                  title: 'Merokok',
                  calculate: counts['rokokCount']! / 7,
                  total: '${counts['rokokCount']}/7',
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
