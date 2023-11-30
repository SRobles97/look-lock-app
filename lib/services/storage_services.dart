import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StorageServices {
  static Future<String?> uploadImageToGitHub(File imageFile) async {
    final String fileName = _generateUniqueFileName('looklock', 'jpg');
    final String repoOwner = dotenv.env['GITHUB_USER']!;
    final String repoName = dotenv.env['GITHUB_REPO']!;
    final String authToken = dotenv.env['GITHUB_AUTH_TOKEN']!;

    final url =
        'https://api.github.com/repos/$repoOwner/$repoName/contents/$fileName';
    final bytes = imageFile.readAsBytesSync();
    final base64Image = base64Encode(bytes);

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message': 'Subir imagen',
        'content': base64Image,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final imageUrl = responseData['content']['download_url'];
      return imageUrl;
    } else {
      if (kDebugMode) {
        print('Error al cargar la imagen: ${response.statusCode}');
      }
      return null;
    }
  }

  static String _generateUniqueFileName(String prefix, String extension) {
    final random = Random();
    final randomNumber = random.nextInt(999999);
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$prefix$randomNumber$timestamp.$extension';
  }
}
