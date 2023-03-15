// lire passage calendrier
class ListPassages {
  final List<Passages> passages;

  ListPassages({
    required this.passages,
  });

  factory ListPassages.fromJson(List<dynamic> parsedJson) {
    List<Passages> passages = <Passages>[];
    passages = parsedJson.map((i) => Passages.fromJson(i)).toList();

    return ListPassages(passages: passages);
  }
}

class Passages {
  final String? title;
  final String text_1;
  final String text_2;
  final String text_3;

  Passages(
      {required this.text_1,
      required this.text_2,
      required this.text_3,
      this.title});

  factory Passages.fromJson(Map<String, dynamic> json) {
    return Passages(
      title: json['A'],
      text_1: json['B'],
      text_2: json['C'],
      text_3: json['D'],
    );
  }
}
