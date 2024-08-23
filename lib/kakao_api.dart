import 'package:http/http.dart' as http; // HTTP 요청을 보내기 위한 패키지
import 'dart:convert'; // JSON 데이터를 디코딩하기 위한 패키지
import 'package:flutter_dotenv/flutter_dotenv.dart'; // .env 파일에서 환경 변수를 로드하기 위한 패키지

class KakaoAPI {
  final String apiKey = dotenv.env['KAKAO_API_KEY']!; // .env 파일에서 Kakao API 키를 가져옴

  // Kakao API를 사용해 장소를 검색하는 함수
  Future<List<Map<String, dynamic>>> searchPlaces(String query,
      {double? latitude, double? longitude, int radius = 20000}) async { // 검색어(query)와 선택적으로 위도, 경도, 반경(radius)을 인자로 받음
    final String url = 'https://dapi.kakao.com/v2/local/search/keyword.json'; // Kakao API의 URL
    String requestUrl = '$url?query=$query&radius=$radius'; // 기본적인 요청 URL 생성 (검색어와 반경 포함)

    // 위도와 경도가 제공된 경우에만 URL에 추가
    if (latitude != null && longitude != null) {
      requestUrl += '&y=$latitude&x=$longitude'; // 위도(y)와 경도(x)를 URL에 추가
    }

    // HTTP GET 요청을 보내고 응답을 받음
    final response = await http.get(
      Uri.parse(requestUrl), // URI로 변환된 요청 URL
      headers: {
        'Authorization': 'KakaoAK $apiKey', // 요청 헤더에 Kakao API 키 추가
      },
    );

    // 요청이 성공적으로 완료된 경우
    if (response.statusCode == 200) {
      final data = json.decode(response.body); // 응답 바디를 JSON으로 디코딩
      return List<Map<String, dynamic>>.from(data['documents']); // 'documents' 필드에서 데이터를 추출하여 리스트로 변환
    } else {
      print('Response body: ${response.body}'); // 에러 발생 시 응답 바디를 출력
      throw Exception('Failed to load places'); // 예외 발생
    }
  }
}

// 만약 위도와 경도가 정해진 상태에서 찾고 싶다면? 예시 코드

// import 'package:http/http.dart' as http; // HTTP 요청을 보내기 위한 패키지 import
// import 'dart:convert'; // JSON 데이터를 디코딩하기 위한 패키지 import
// import 'package:flutter_dotenv/flutter_dotenv.dart'; // .env 파일에서 환경 변수를 로드하기 위한 패키지 import
//
// class KakaoAPI {
//  final String apiKey = dotenv.env['KAKAO_API_KEY']!; // .env 파일에서 Kakao API 키를 가져옴
//
//  // 서울을 중심으로 하는 기본 좌표값 설정
//  final double defaultLatitude = 37.5665; // 서울의 위도
//  final double defaultLongitude = 126.9780; // 서울의 경도
//
//  // Kakao API를 사용해 장소를 검색하는 함수 (기본 좌표값을 사용하는 버전)
//  Future<List<Map<String, dynamic>>> searchPlaces(String query, {double? latitude, double? longitude, int radius = 20000}) async {
//    final String url = 'https://dapi.kakao.com/v2/local/search/keyword.json'; // Kakao API의 URL
//
//    // 위도와 경도가 제공되지 않았을 경우 기본 좌표값 사용
//    final String requestUrl = '$url?query=$query&y=${latitude ?? defaultLatitude}&x=${longitude ?? defaultLongitude}&radius=$radius'; // 요청 URL 생성 (검색어와 반경 포함, 좌표값은 기본값 또는 사용자 지정)
//
//    // HTTP GET 요청을 보내고 응답을 받음
//    final response = await http.get(
//      Uri.parse(requestUrl), // URI로 변환된 요청 URL
//      headers: {
//        'Authorization': 'KakaoAK $apiKey', // 요청 헤더에 Kakao API 키 추가
//      },
//    );
//
//    // 요청이 성공적으로 완료된 경우
//    if (response.statusCode == 200) {
//      final data = json.decode(response.body); // 응답 바디를 JSON으로 디코딩
//      return List<Map<String, dynamic>>.from(data['documents']); // 'documents' 필드에서 데이터를 추출하여 리스트로 변환
//    } else {
//      print('Response body: ${response.body}'); // 에러 발생 시 응답 바디를 출력
//      throw Exception('Failed to load places'); // 예외 발생
//    }
//  }
// }
