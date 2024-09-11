import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_datas.dart';

part 'history_answer.freezed.dart';
part 'history_answer.g.dart';

@freezed
class HistoryAnswers with _$HistoryAnswers {
  const factory HistoryAnswers({
    required String materiId,
    required ItemDatas results,
    required DateTime timestamp,
    required String userId,
  }) = _HistoryAnswers;

  factory HistoryAnswers.fromJson(Map<String, dynamic> json) =>
      _$HistoryAnswersFromJson(json);
}
