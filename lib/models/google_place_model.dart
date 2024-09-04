import 'package:flutter_dotenv/flutter_dotenv.dart';


//일단 사용 가능한 정보 죄다 끌어옴

class GooglePlaceModel {
  final String id;  // 장소의 고유 ID
  final String name;  // 장소 이름
  final String address;  // 주소
  final List<String>? photoUrls;  // 장소의 사진 URL 리스트, 없을 수도 있음
  final double? rating;  // 장소의 평점
  final bool? isOpenNow;  // 현재 영업 중인지
  final String? phoneNumber;  // 전화번호
  final String? website;  // 웹사이트 URL
  final double? latitude;  // 위도
  final double? longitude; // 경도

  // 새로 추가된 필드들
  final List<String>? currentOpeningHours; // 현재 영업시간
  final List<String>? reviews; // 리뷰
  final List<String>? types; // 장소 유형

  // 생성자
  GooglePlaceModel({
    required this.id,
    required this.name,
    required this.address,
    this.photoUrls,
    this.rating,
    this.isOpenNow,
    this.phoneNumber,
    this.website,
    this.latitude,
    this.longitude,
    this.currentOpeningHours, // 추가된 필드
    this.reviews, // 추가된 필드
    this.types, // 추가된 필드
  });

  // fromJson 팩토리 생성자 - JSON 데이터를 받아 GooglePlaceModel 인스턴스를 생성
  factory GooglePlaceModel.fromJson(Map<String, dynamic> json) {
    try {
      final apiKey = dotenv.env['GOOGLE_API_KEY'];

      return GooglePlaceModel(
        id: json['place_id'] ?? 'Unknown ID',
        name: json['name'] ?? 'Unknown Name',
        address: json['formatted_address'] ?? 'Unknown Address',
        photoUrls: json['photos'] != null
            ? (json['photos'] as List)
            .map((photo) =>
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photo['photo_reference']}&key=$apiKey')
            .toList()
            : null,
        rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
        isOpenNow: json['opening_hours'] != null ? json['opening_hours']['open_now'] as bool : null,
        phoneNumber: json['formatted_phone_number'],
        website: json['website'],
        latitude: json['geometry'] != null && json['geometry']['location'] != null
            ? json['geometry']['location']['lat'] as double
            : null,
        longitude: json['geometry'] != null && json['geometry']['location'] != null
            ? json['geometry']['location']['lng'] as double
            : null,
        currentOpeningHours: json['opening_hours'] != null && json['opening_hours']['weekday_text'] != null
            ? List<String>.from(json['opening_hours']['weekday_text'])
            : null,
        reviews: json['reviews'] != null ? (json['reviews'] as List).map((review) => review['text'] as String).toList() : null,
        types: json['types'] != null ? List<String>.from(json['types']) : null,
      );
    } catch (e) {
      print('Error parsing JSON: $e');
      return GooglePlaceModel(
        id: 'Unknown ID',
        name: 'Unknown Name',
        address: 'Unknown Address',
        photoUrls: [],
        rating: null,
        isOpenNow: null,
        phoneNumber: null,
        website: null,
        latitude: null,
        longitude: null,
        currentOpeningHours: null, // 추가된 필드 초기화
        reviews: null, // 추가된 필드 초기화
        types: null, // 추가된 필드 초기화
      );
    }
  }
}

