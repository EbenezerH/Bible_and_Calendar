class BibleClass {
  final int? id;
  final List<Testament>? listTestaments;
  final String? text;

  BibleClass({this.id, this.listTestaments, this.text});

  factory BibleClass.fromJson(Map<String, dynamic> json) {
    var list = json['Testaments'] as List;
    List<Testament> listTestaments =
        list.map((i) => Testament.fromJson(i)).toList();
    return BibleClass(
      id: json['ID'] ?? 1,
      listTestaments: listTestaments,
      text: json['Text'],
    );
  }
}

class Testament {
  final int? id;
  final List<Books>? listBooks;
  final String? text;

  Testament({this.id, this.listBooks, this.text});

  factory Testament.fromJson(Map<String, dynamic> json) {
    var list = json['Books'] as List;
    List<Books> listBooks = list.map((i) => Books.fromJson(i)).toList();
    return Testament(
      id: json['ID'] ?? 1,
      listBooks: listBooks,
      text: json['Text'],
    );
  }
}

class Books {
  final int? id;
  final List<Chapters>? listChapters;
  final String? text;

  Books({this.id, this.listChapters, this.text});

  factory Books.fromJson(Map<String, dynamic> json) {
    var list = json['Chapters'] as List;
    List<Chapters> listChapters =
        list.map((i) => Chapters.fromJson(i)).toList();
    return Books(
      id: json['ID'] ?? 0,
      listChapters: listChapters,
      text: json['Text'],
    );
  }
}

class Chapters {
  int? id;
  final List<Verses>? listVerses;

  Chapters({
    this.id,
    this.listVerses,
  });

  factory Chapters.fromJson(Map<String, dynamic> json) {
    var list = json['Verses'] as List;
    List<Verses> listVerses = list.map((i) => Verses.fromJson(i)).toList();
    return Chapters(
      id: json['ID'] ?? 1,
      listVerses: listVerses,
    );
  }
}

class Verses {
  final int? id;
  final String? text;
  bool isSelected;

  Verses({this.id, this.text, this.isSelected = false});

  factory Verses.fromJson(Map<String, dynamic> json) {
    return Verses(
      id: json['ID'] ?? 1,
      text: json['Text'],
    );
  }
}
