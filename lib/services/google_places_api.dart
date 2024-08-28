import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GooglePlacesAPI {
  final String apiKey = dotenv.env['GOOGLE_API_KEY']!;

  Future<List<dynamic>> searchPlaces(String query) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          return data['results'];
        } else {
          print('API Error: ${data['status']} - ${data['error_message']}');
          throw Exception('Failed to load places');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        throw Exception('Failed to load places');
      }
    } catch (e) {
      print('Exception during API call: $e');
      throw Exception('Failed to load places');
    }
  }

  Future<String?> fetchPhotoUrl(String photoReference) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.headers['location'];
      } else {
        print('HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception during photo API call: $e');
      return null;
    }
  }
}
