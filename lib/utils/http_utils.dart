import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:look_lock_app/services/storage_services.dart';

import 'package:http/http.dart' as http;

class HttpUtils {
  static final String _apiUrl = dotenv.env['API_URL']!;

  static Future<String?> getUserToken() async {
    try {
      return await StorageServices.getToken();
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener el accessToken de SharedPreferences: $e');
      }
      return null;
    }
  }

  static Map<String, String> getHeaders(String? token) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  static bool checkResponse(http.Response response) {
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Uri getUri(String endpoint) {
    return Uri.http(_apiUrl, dotenv.env[endpoint]!);
  }

  static Uri getUriWithParam(String endpoint, [String pathSuffix = '']) {
    return Uri.http(_apiUrl, '${dotenv.env[endpoint]!}/$pathSuffix');
  }
}
