import 'package:intl/intl.dart';

class Weathermodel {
  int? id;
  final String cityName;
  bool isPined;

  Weathermodel({this.id, required this.cityName, required this.isPined});

  Map<String, dynamic> toMap() {
    return {'id': id, 'cityName': cityName, 'isPined': isPined ? 1 : 0};
  }

  @override
  String toString() {
    return 'Weather(id: $id , cityName: $cityName , isPined: $isPined';
  }
}
