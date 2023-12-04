import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:look_lock_app/models/alert.dart';
import 'package:look_lock_app/models/projected_alert.dart';
import 'package:http/http.dart' as http;
import 'package:look_lock_app/utils/http_utils.dart';

class AlertServices {
  Future<List<ProjectedAlert>> fetchProjectedAlerts() async {
    String? accessToken = await HttpUtils.getUserToken();
    if (accessToken == null) {
      if (kDebugMode) {
        print('Error: AccessToken es nulo');
      }
      return [];
    }

    final url = HttpUtils.getUri('GET_ALL_ATTEMPTS_URL');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (HttpUtils.checkResponse(response)) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return ProjectedAlert.fromJsonList(jsonData);
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al realizar la petición: $e');
      }
      return [];
    }
  }

  Future<Alert> fetchAlert(int alertId) async {
    String? accessToken = await HttpUtils.getUserToken();
    if (accessToken == null) {
      if (kDebugMode) {
        print('Error: AccessToken es nulo');
      }
      return Alert(id: 0, date: '', time: '', imageTaken: '');
    }

    final url =
        HttpUtils.getUriWithParam('GET_ATTEMPT_URL', alertId.toString());

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (HttpUtils.checkResponse(response)) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        return Alert.fromJson(jsonData);
      } else {
        return Alert(id: 0, date: '', time: '', imageTaken: '');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al realizar la petición: $e');
      }
      return Alert(id: 0, date: '', time: '', imageTaken: '');
    }
  }

  Future<List<ProjectedAlert>> fetchAlertsByDate(String date) async {
    String? accessToken = await HttpUtils.getUserToken();
    if (accessToken == null) {
      if (kDebugMode) {
        print('Error: AccessToken es nulo');
      }
      return [];
    }

    final url = HttpUtils.getUriWithParam('GET_ATTEMPTS_BY_DATE_URL', date);

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (HttpUtils.checkResponse(response)) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return ProjectedAlert.fromJsonList(jsonData);
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al realizar la petición: $e');
      }
      return [];
    }
  }

  Future<List<ProjectedAlert>> fetchAlertsByDateAndTimeRange(
      String date, String start, String end) async {
    String? accessToken = await HttpUtils.getUserToken();
    if (accessToken == null) {
      if (kDebugMode) {
        print('Error: AccessToken es nulo');
      }
      return [];
    }
    final url = HttpUtils.getUriWithParam('GET_ATTEMPTS_BY_TIME_RANGE_URL',
        'date/$date/from/${start.replaceFirst(':', '-')}/to/${end.replaceFirst(':', '-')}');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (HttpUtils.checkResponse(response)) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return ProjectedAlert.fromJsonList(jsonData);
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al realizar la petición: $e');
      }
      return [];
    }
  }
}
