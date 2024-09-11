// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryAnswersImpl _$$HistoryAnswersImplFromJson(Map<String, dynamic> json) =>
    _$HistoryAnswersImpl(
      materiId: json['materiId'] as String,
      results: ItemDatas.fromJson(json['results'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$HistoryAnswersImplToJson(
        _$HistoryAnswersImpl instance) =>
    <String, dynamic>{
      'materiId': instance.materiId,
      'results': instance.results,
      'timestamp': instance.timestamp.toIso8601String(),
      'userId': instance.userId,
    };
