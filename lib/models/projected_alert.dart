class ProjectedAlert {
  final int id;
  final String date;
  final String time;

  ProjectedAlert({required this.id, required this.date, required this.time});

  factory ProjectedAlert.fromJson(Map<String, dynamic> json) {
    return ProjectedAlert(
      id: json['id'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'time': time,
      };
}
