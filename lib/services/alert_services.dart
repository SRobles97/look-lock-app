import 'package:look_lock_app/models/projected_alert.dart';

class AlertServices {
  Future<List<ProjectedAlert>> fetchAlerts() async {
    return [
      ProjectedAlert(
        id: 1,
        date: '2023-10-10',
        time: '10:03',
      ),
      ProjectedAlert(
        id: 2,
        date: '2023-10-10',
        time: '10:10',
      ),
      ProjectedAlert(
        id: 3,
        date: '2023-10-10',
        time: '10:12',
      ),
      ProjectedAlert(
        id: 4,
        date: '2023-10-10',
        time: '10:13',
      ),
      ProjectedAlert(
        id: 5,
        date: '2023-10-10',
        time: '10:14',
      ),
      ProjectedAlert(
        id: 6,
        date: '2023-10-10',
        time: '10:15',
      ),
    ];
  }
}
