import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final _instance = FirebaseAnalytics.instance;

  Future<void> logMateri(String? userId, String materiId) async {
    await _instance.logTutorialComplete(
        parameters: {"userId": userId, "MateriId": materiId});
    await _instance.logEvent(
        name: 'materi_pasien',
        parameters: {"userId": userId, "MateriId": materiId});
  }
}
