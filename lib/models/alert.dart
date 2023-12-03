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
    return Alert(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      imageTaken: json['image_taken'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'time': time,
        'image_taken': imageTaken,
      };
}
