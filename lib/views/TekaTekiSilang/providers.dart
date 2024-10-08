import 'dart:developer';

import 'package:cardi_care/views/TekaTekiSilang/types/history_answer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'types/item_datas.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/tts_service.dart';
import 'types/tts.dart';
import 'types/table_map.dart';
import 'types/direction.dart';

class TtsNotifier extends StateNotifier<Tts> {
  final TtsService _ttsService;

  TtsNotifier(this._ttsService)
      : super(const Tts(
          isLoading: true,
          isClear: false,
          isSaving: false,
          name: '',
          materiID: '',
          col: 0,
          row: 0,
          items: [],
          table: [],
        ));

  bool getLoading() {
    return state.isLoading;
  }

  List<ItemDatas> getStateItems() {
    return state.items;
  }

  Future<Tts> getTtsData(String id) async {
    // final ttsData = await _ttsService.getTtsData(id);
    final ttsData = await _ttsService.getTtsDataByMateriID(id);
    final json = ttsData.toMap();

    List<ItemDatas> itemsConverted = [];

    for (var jsonItem in json['items']) {
      itemsConverted.add(ItemDatas(
        title: jsonItem['title'],
        answer: jsonItem['answer'],
        direction: jsonItem['direction'],
        startCol: jsonItem['startCol'],
        startRow: jsonItem['startRow'],
        number: jsonItem['number'],
        isAnswered: false,
      ));
    }

    state = state.copyWith(
        name: json['name'],
        col: json['col'],
        row: json['row'],
        materiID: json['materi_id'],
        items: itemsConverted,
        isClear: false);

    convertToMatrix(state.items, state.col, state.row);

    await getHistoryAnswers();

    state = state.copyWith(isLoading: false);

    return state;
  }

  String getTtsMateriId() {
    return state.materiID;
  }

  void updateTts(Tts tts) {
    state = tts;
  }

  bool isClear() {
    return state.isClear;
  }

  bool getSavingStatus() {
    return state.isSaving;
  }

  void isSaving(bool val) {
    state = state.copyWith(isSaving: val);
  }

  void clearTts() {
    state = state.copyWith(
      isLoading: true,
      isClear: false,
      name: '',
      materiID: '',
      col: 0,
      row: 0,
      items: [],
      table: [],
    );
  }

  List<String> getVerticalQuestion() {
    List<String> questions = [];

    final sortetState = state.items.toList()
      ..sort((a, b) => a.number.compareTo(b.number));

    for (final item in sortetState) {
      if (item.direction == 'vertical') {
        questions.add('${item.number}. ${item.title}');
      }
    }

    return questions;
  }

  List<String> getHorizontalQuestion() {
    List<String> questions = [];

    for (final item in state.items) {
      if (item.direction == 'horizontal') {
        questions.add('${item.number}. ${item.title}');
      }
    }

    return questions;
  }

  void convertToMatrix(List<ItemDatas> items, int col, int row) {
    List<List<TableMap>> matrix = List<List<TableMap>>.generate(row, (i) {
      return List<TableMap>.generate(
          col,
          (j) => const TableMap(
                value: null,
                number: null,
                answerIndex: null,
                direction: Direction(horizontal: false, vertical: false),
                isAnswered: false,
              ));
    });

    for (final entry in items.asMap().entries) {
      final index = entry.key;
      final item = entry.value;

      List<String> answer = item.answer.toString().split('');

      if (item.direction == 'horizontal') {
        for (var i = 0; i < answer.length; i++) {
          var vertical = false;
          final row = item.startRow;
          final col = item.startCol + i;

          if (matrix[row][col].direction.vertical == true) {
            vertical = true;
          }

          matrix[row][col] = TableMap(
            value: '',
            answerIndex: index,
            number: (matrix[row][col].number == null && i == 0)
                ? item.number
                : matrix[row][col].number,
            direction: Direction(horizontal: true, vertical: vertical),
            isAnswered: false,
          );
        }
      } else {
        for (var i = 0; i < answer.length; i++) {
          var horizontal = false;
          final row = item.startRow + i;
          final col = item.startCol;

          if (matrix[row][col].direction.horizontal == true) {
            horizontal = true;
          }

          matrix[row][col] = TableMap(
            value: '',
            answerIndex: index,
            number: (matrix[row][col].number == null && i == 0)
                ? item.number
                : matrix[row][col].number,
            direction: Direction(horizontal: horizontal, vertical: true),
            isAnswered: false,
          );
        }
      }
    }

    state = state.copyWith(table: matrix);
  }

  void changeDirection(
      {required row, required column, required Direction direction}) {}

  void answerQuestion(ItemDatas item) {
    final answer = item.answer.split('');

    for (var i = 0; i < answer.length; i++) {
      if (item.direction == 'horizontal') {
        final row = item.startRow;
        final col = item.startCol + i;

        state = state.copyWith(
          table: state.table
              .asMap()
              .map(
                (h, e) => MapEntry(
                  h,
                  e
                      .asMap()
                      .map(
                        (j, r) => MapEntry(
                          j,
                          h == row && j == col
                              ? r.copyWith(
                                  value: answer[i],
                                  isAnswered: true,
                                )
                              : r,
                        ),
                      )
                      .values
                      .toList(),
                ),
              )
              .values
              .toList(),
          items: state.items
              .map((e) =>
                  e.number == item.number ? e.copyWith(isAnswered: true) : e)
              .toList(),
        );
      } else {
        final row = item.startRow + i;
        final col = item.startCol;

        state = state.copyWith(
          table: state.table
              .asMap()
              .map(
                (h, e) => MapEntry(
                  h,
                  e
                      .asMap()
                      .map(
                        (j, r) => MapEntry(
                          j,
                          h == row && j == col
                              ? r.copyWith(
                                  value: answer[i],
                                  isAnswered: true,
                                )
                              : r,
                        ),
                      )
                      .values
                      .toList(),
                ),
              )
              .values
              .toList(),
          items: state.items
              .map((e) =>
                  e.number == item.number ? e.copyWith(isAnswered: true) : e)
              .toList(),
        );
      }
    }
  }

  Future<List<HistoryAnswers>> getHistoryAnswers() async {
    List<HistoryAnswers> historyAnswers = [];
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? userId = auth.currentUser;
    final ttsHistoryAnswer =
        await _ttsService.getHistoryAnswer(userId!.uid, state.materiID);

    for (final answer in ttsHistoryAnswer) {
      historyAnswers.add(HistoryAnswers(
          materiId: answer.materiId,
          results: ItemDatas(
            title: answer.results.title,
            direction: answer.results.direction,
            answer: answer.results.answer,
            startCol: answer.results.startCol,
            startRow: answer.results.startRow,
            number: answer.results.number,
            isAnswered: true,
          ),
          timestamp: answer.timestamp,
          userId: answer.userId));

      answerQuestion(answer.results);
    }

    if (ttsHistoryAnswer.isNotEmpty) {
      state = state.copyWith(isClear: true);
    }

    return historyAnswers;
  }
}

final ttsNotifierProvider = StateNotifierProvider<TtsNotifier, Tts>((ref) {
  TtsService ttsService = TtsService();
  return TtsNotifier(ttsService);
});
