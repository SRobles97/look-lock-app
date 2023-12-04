import 'package:intl/intl.dart';

class ProjectedAlert {
  final int id;
  final String date;
  final String time;

  ProjectedAlert({required this.id, required this.date, required this.time});

  factory ProjectedAlert.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.parse(json['timestamp']);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    String formattedTime = DateFormat('HH:mm').format(parsedDate);

    return ProjectedAlert(
      id: json['id'],
      date: formattedDate,
      time: formattedTime,
    );
  }

  static List<ProjectedAlert> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProjectedAlert.fromJson(json)).toList();
  }
}
