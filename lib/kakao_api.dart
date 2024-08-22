import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class KakaoAPI {
  final String apiKey = dotenv.env['KAKAO_API_KEY']!;

  Future<List<Map<String, dynamic>>> searchPlaces(String query, {double? latitude, double? longitude, int radius = 20000}) async {
    final String url = 'https://dapi.kakao.com/v2/local/search/keyword.json';
    final response = await http.get(
      Uri.parse('$url?query=$query&y=$latitude&x=$longitude&radius=$radius'),
      headers: {
        'Authorization': 'KakaoAK $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['documents']);
    } else {
      throw Exception('Failed to load places');
    }
  }
}