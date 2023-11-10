import 'laureate.dart';

class NoblePrize {
  final String year;
  final String category;
  final List<Laureate> laureates;

  NoblePrize({
    required this.year,
    required this.category,
    required this.laureates,
  });

  factory NoblePrize.fromJson(Map<String, dynamic> json) {
    final List<dynamic> laureatesList = json['laureates'];

    final laureates = laureatesList.map((laureateJson) {
      return Laureate.fromJson(laureateJson);
    }).toList();

    return NoblePrize(
      year: json['year'],
      category: json['category'],
      laureates: laureates,
    );
  }
}
