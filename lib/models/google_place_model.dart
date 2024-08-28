import 'package:flutter_dotenv/flutter_dotenv.dart';

class GooglePlaceModel {
  final String id;
  final String name;
  final String address;
  final List<String>? photoUrls;
  final double? rating;
  final bool? isOpenNow;
  final String? phoneNumber;
  final String? website;
  final double? latitude;  // 위도 추가
  final double? longitude; // 경도 추가

  GooglePlaceModel({
    required this.id,
    required this.name,
    required this.address,
    this.photoUrls,
    this.rating,
    this.isOpenNow,
    this.phoneNumber,
    this.website,
    this.latitude,  // 위도 추가
    this.longitude, // 경도 추가
  });

  factory GooglePlaceModel.fromJson(Map<String, dynamic> json) {
    try {
      final apiKey = dotenv.env['GOOGLE_API_KEY']; // API 키 로드

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
        isOpenNow: json['opening_hours'] != null
            ? json['opening_hours']['open_now'] as bool
            : null,
        phoneNumber: json['formatted_phone_number'],
        website: json['website'],
        latitude: json['geometry'] != null && json['geometry']['location'] != null
            ? json['geometry']['location']['lat'] as double
            : null, // 위도
        longitude: json['geometry'] != null && json['geometry']['location'] != null
            ? json['geometry']['location']['lng'] as double
            : null, // 경도
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
      );
    }
  }
}
