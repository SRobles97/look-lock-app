import 'package:intl/intl.dart';

class Alert {
  final int id;
  final String date;
  final String time;
  final String imageTaken;

  Alert(
      {required this.id,
      required this.date,
      required this.time,
      required this.imageTaken});

  factory Alert.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.parse(json['timestamp']);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    String formattedTime = DateFormat('HH:mm').format(parsedDate);

    return Alert(
      id: json['id'],
      date: formattedDate,
      time: formattedTime,
      imageTaken: json['attempted_url'],
    );
  }

  static List<Alert> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Alert.fromJson(json)).toList();
  }
}
