import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:look_lock_app/services/storage_services.dart';

class AuthServices {
  final String ipAddress = dotenv.env['API_URL']!;

  Future<String> signUp(
      String email, String username, String password, String imageUrl) async {
    final url = Uri.http(ipAddress, dotenv.env['REGISTER_URL']!);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': username,
        'password': password,
        'image_url': imageUrl
      }),
    );
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return decodedResponse['message'];
    } else if (response.statusCode == 400) {
      return decodedResponse['message'];
    } else {
      return 'Error al registrarse, intente nuevamente.';
    }
  }

  Future<String> signInWithPhoto(String imageUrl) async {
    final url = Uri.http(ipAddress, dotenv.env['LOGIN_WITH_IMAGE_URL']!);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'image_url': imageUrl}),
    );

    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await StorageServices.setToken(decodedResponse['access_token']);
      return decodedResponse['message'];
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      return decodedResponse['message'];
    } else {
      return 'Error al iniciar sesión, intente nuevamente.';
    }
  }
}
