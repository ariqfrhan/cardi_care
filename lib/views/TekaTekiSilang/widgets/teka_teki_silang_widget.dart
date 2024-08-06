import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import 'teka_teki_silang_drawer_answer.dart';
import '../providers.dart';

class TekaTekiSilangWidget extends ConsumerStatefulWidget {
  const TekaTekiSilangWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<TekaTekiSilangWidget> createState() =>
      _TekaTekiSilangWidgetState();
}

class _TekaTekiSilangWidgetState extends ConsumerState<TekaTekiSilangWidget> {
  @override
  void initState() {
    super.initState();
    ref.read(ttsNotifierProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final ttsData = ref.watch(ttsNotifierProvider);

    if (ttsData.col <= 0 || ttsData.row <= 0) {
      return const Center(child: Text('Data TTS tidak valid'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: TableView.builder(
            diagonalDragBehavior: DiagonalDragBehavior.free,
            cellBuilder: _buildCell,
            columnCount: ttsData.col,
            columnBuilder: (index) => _buildSpan(context, index),
            rowCount: ttsData.row,
            rowBuilder: (index) => _buildSpan(context, index),
          ),
        );
      },
    );
  }

  TableSpan _buildSpan(BuildContext context, int index) {
    return const TableSpan(
      extent: FixedTableSpanExtent(60),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    final ttsData = ref.watch(ttsNotifierProvider);

    return TableViewCell(
      child: Consumer(
        builder: (context, ref, _) {
          var spanActive = ttsData.table[vicinity.row][vicinity.column];

          if (spanActive.value != null) {
            return GestureDetector(
              onTap: () {
                containerEventListener(
                  context,
                  vicinity.row,
                  vicinity.column,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  color:
                      spanActive.value != '' ? Colors.grey[200] : Colors.white,
                  shape: BoxShape.rectangle,
                ),
                padding: const EdgeInsets.all(4),
                child: Stack(
                  children: [
                    floatingNumberCrossword(context, spanActive.number ?? 0),
                    Center(
                      child: Text(
                        spanActive.value?.toUpperCase() ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ColoredBox(
            color: Theme.of(context).colorScheme.primaryContainer,
          );
        },
      ),
    );
  }

  Widget floatingNumberCrossword(BuildContext context, int number) {
    if (number == 0) return Container();

    return Positioned(
      top: 0,
      left: 0,
      height: 20,
      width: 20,
      child: Text(
        number.toString(),
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  void containerEventListener(BuildContext context, int row, int column) {
    final ttsData = ref.watch(ttsNotifierProvider);
    final currentMatrix = ttsData.table[row][column];
    final currentItem = ref.read(ttsNotifierProvider).items.where((element) {
      return element.isAnswered == false &&
          element.startCol == column &&
          element.startRow == row;
    }).toList();

    if (currentMatrix.direction.horizontal &&
        currentMatrix.direction.vertical) {
      if (currentItem.isEmpty) return;

      if (currentItem.length > 1) {
        showFloatingActionButton(context, row, column);
      } else {
        if (currentItem[0].direction == 'horizontal') {
          showDrawerAnswer(context, row, column, 'horizontal');
        } else {
          showDrawerAnswer(context, row, column, 'vertical');
        }
      }
    } else {
      if (!currentMatrix.isAnswered!) {
        if (currentMatrix.direction.horizontal == true) {
          showDrawerAnswer(context, row, column, 'horizontal');
        } else {
          showDrawerAnswer(context, row, column, 'vertical');
        }
      }
    }
  }

  void showDrawerAnswer(
    BuildContext context,
    int row,
    int column,
    String direction,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                TekaTekiSilangDrawerAnswer(
                  row: row,
                  column: column,
                  direction: direction,
                ),
              ],
            ),
          ),
        );
      },
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  void showFloatingActionButton(BuildContext context, int row, int column) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: const Text(
            'Pilih Arah yang ingin di jawab',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDrawerAnswer(context, row, column, 'horizontal');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  'Mendatar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDrawerAnswer(context, row, column, 'vertical');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  'Menurun',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
