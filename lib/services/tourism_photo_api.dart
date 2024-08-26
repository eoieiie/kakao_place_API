import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TourismPhotoAPI {
  final String apiKey = dotenv.env['KAKAO_API_KEY'] ?? ''; // .env에서 API 키 가져오기
  final String endPoint = 'http://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList';

  Future<String?> fetchPhotoUrl(String placeName) async {
    final String requestUrl = '$endPoint?serviceKey=$apiKey&numOfRows=1&pageNo=1&arrange=A&keyword=$placeName&_type=json';

    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['response']['body']['items'].isNotEmpty) {
        return data['response']['body']['items'][0]['galWebImageUrl'];  // 사진 URL 반환
      }
    } else {
      print('Failed to load photo URL');
    }
    return null;
  }
}
