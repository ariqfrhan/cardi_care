class ItemsType {
  final String title = '';
  final String answer = '';
  final String direction = '';
  final int startCol = 0;
  final int startRol = 0;
  final int number = 0;
}

class TtsModel {
  final int col;
  final int row;
  final String name;
  final String materiID;
  final List<dynamic> items;

  TtsModel({
    required this.col,
    required this.row,
    required this.name,
    required this.materiID,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'col': col,
      'row': row,
      'name': name,
      'materi_id': materiID,
      'items': items,
    };
  }

  factory TtsModel.fromMap(Map<String, dynamic> map) {
    return TtsModel(
      col: map['col'],
      row: map['row'],
      name: map['name'],
      materiID: map['materiID'],
      items: map['items'],
    );
  }
}
