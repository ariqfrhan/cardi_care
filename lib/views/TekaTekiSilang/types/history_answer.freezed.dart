// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HistoryAnswers _$HistoryAnswersFromJson(Map<String, dynamic> json) {
  return _HistoryAnswers.fromJson(json);
}

/// @nodoc
mixin _$HistoryAnswers {
  String get materiId => throw _privateConstructorUsedError;
  ItemDatas get results => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryAnswersCopyWith<HistoryAnswers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryAnswersCopyWith<$Res> {
  factory $HistoryAnswersCopyWith(
          HistoryAnswers value, $Res Function(HistoryAnswers) then) =
      _$HistoryAnswersCopyWithImpl<$Res, HistoryAnswers>;
  @useResult
  $Res call(
      {String materiId, ItemDatas results, DateTime timestamp, String userId});

  $ItemDatasCopyWith<$Res> get results;
}

/// @nodoc
class _$HistoryAnswersCopyWithImpl<$Res, $Val extends HistoryAnswers>
    implements $HistoryAnswersCopyWith<$Res> {
  _$HistoryAnswersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materiId = null,
    Object? results = null,
    Object? timestamp = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      materiId: null == materiId
          ? _value.materiId
          : materiId // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as ItemDatas,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemDatasCopyWith<$Res> get results {
    return $ItemDatasCopyWith<$Res>(_value.results, (value) {
      return _then(_value.copyWith(results: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HistoryAnswersImplCopyWith<$Res>
    implements $HistoryAnswersCopyWith<$Res> {
  factory _$$HistoryAnswersImplCopyWith(_$HistoryAnswersImpl value,
          $Res Function(_$HistoryAnswersImpl) then) =
      __$$HistoryAnswersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String materiId, ItemDatas results, DateTime timestamp, String userId});

  @override
  $ItemDatasCopyWith<$Res> get results;
}

/// @nodoc
class __$$HistoryAnswersImplCopyWithImpl<$Res>
    extends _$HistoryAnswersCopyWithImpl<$Res, _$HistoryAnswersImpl>
    implements _$$HistoryAnswersImplCopyWith<$Res> {
  __$$HistoryAnswersImplCopyWithImpl(
      _$HistoryAnswersImpl _value, $Res Function(_$HistoryAnswersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materiId = null,
    Object? results = null,
    Object? timestamp = null,
    Object? userId = null,
  }) {
    return _then(_$HistoryAnswersImpl(
      materiId: null == materiId
          ? _value.materiId
          : materiId // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as ItemDatas,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryAnswersImpl implements _HistoryAnswers {
  const _$HistoryAnswersImpl(
      {required this.materiId,
      required this.results,
      required this.timestamp,
      required this.userId});

  factory _$HistoryAnswersImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryAnswersImplFromJson(json);

  @override
  final String materiId;
  @override
  final ItemDatas results;
  @override
  final DateTime timestamp;
  @override
  final String userId;

  @override
  String toString() {
    return 'HistoryAnswers(materiId: $materiId, results: $results, timestamp: $timestamp, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryAnswersImpl &&
            (identical(other.materiId, materiId) ||
                other.materiId == materiId) &&
            (identical(other.results, results) || other.results == results) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, materiId, results, timestamp, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryAnswersImplCopyWith<_$HistoryAnswersImpl> get copyWith =>
      __$$HistoryAnswersImplCopyWithImpl<_$HistoryAnswersImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryAnswersImplToJson(
      this,
    );
  }
}

abstract class _HistoryAnswers implements HistoryAnswers {
  const factory _HistoryAnswers(
      {required final String materiId,
      required final ItemDatas results,
      required final DateTime timestamp,
      required final String userId}) = _$HistoryAnswersImpl;

  factory _HistoryAnswers.fromJson(Map<String, dynamic> json) =
      _$HistoryAnswersImpl.fromJson;

  @override
  String get materiId;
  @override
  ItemDatas get results;
  @override
  DateTime get timestamp;
  @override
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$HistoryAnswersImplCopyWith<_$HistoryAnswersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
