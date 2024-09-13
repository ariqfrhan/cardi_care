import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final _instance = FirebaseAnalytics.instance;

  Future<void> logMateri(String? userId, String? email, String materiId) async {
    await _instance.logEvent(
        name: '${email!}_$materiId',
        parameters: {"userId": userId, "MateriId": materiId});
  }
}
