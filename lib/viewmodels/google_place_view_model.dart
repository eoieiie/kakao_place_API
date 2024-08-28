import '../models/google_place_model.dart';
import '../services/google_places_api.dart';

class GooglePlaceViewModel {
  final GooglePlacesAPI _googlePlacesAPI = GooglePlacesAPI();

  Future<List<GooglePlaceModel>> searchPlaces(String query) async {
    try {
      final results = await _googlePlacesAPI.searchPlaces(query);

      // API 결과를 로그로 출력하여 확인
      print("API searchPlaces results: $results");

      // JSON 데이터를 GooglePlaceModel로 변환
      final places = results.map<GooglePlaceModel>((json) {
        try {
          return GooglePlaceModel.fromJson(json as Map<String, dynamic>);
        } catch (e) {
          print("Error parsing place JSON: $e");
          return GooglePlaceModel(
            id: 'Unknown ID',
            name: 'Unknown Name',
            address: 'Unknown Address',
            photoUrls: [],
          );
        }
      }).toList();

      // 변환된 데이터 로그 출력
      print("Parsed GooglePlaceModels: $places");

      return places;
    } catch (e) {
      print("Error in searchPlaces: $e");
      return [];
    }
  }

  Future<String?> fetchPhotoUrl(String photoReference) async {
    try {
      final photoUrl = await _googlePlacesAPI.fetchPhotoUrl(photoReference);

      // 가져온 사진 URL 로그로 출력
      print("Fetched photoUrl: $photoUrl");

      return photoUrl;
    } catch (e) {
      print("Error in fetchPhotoUrl: $e");
      return null;
    }
  }
}
