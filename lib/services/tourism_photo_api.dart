import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TourismPhotoAPI {
  final String apiKey = dotenv.env['TOURISM_API_KEY']!;
  final String endPoint = 'http://apis.data.go.kr/B551011/PhotoGalleryService1/gallerySearchList1';

  Future<List<Map<String, dynamic>>?> fetchPhotosByKeyword(String keyword) async {
    final String requestUrl = '$endPoint?serviceKey=$apiKey&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=TestApp&keyword=$keyword&_type=json';

    try {
      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        // 응답 바이트 데이터를 UTF-8로 디코딩
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);
        print('API Response: $data');  // 응답 데이터 출력

        if (data['response']['body']['items'] != null) {
          // items가 단일 객체인지 배열인지 확인하여 처리
          final items = data['response']['body']['items']['item'];
          if (items is List) {
            return List<Map<String, dynamic>>.from(items);
          } else if (items is Map) {
            return [Map<String, dynamic>.from(items)];  // 단일 객체를 리스트로 변환
          }
        } else {
          print('No items found in the response.');
        }
      } else {
        print('Failed to load photos: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error occurred during API call: $e');
    }

    return null;
  }
}
