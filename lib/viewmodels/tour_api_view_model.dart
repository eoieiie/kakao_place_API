import '../models/tour_api_photo_model.dart';
import '../services/tourism_photo_api.dart';

class TourApiViewModel {
  final TourismPhotoAPI _apiService = TourismPhotoAPI();

  Future<List<TourApiPhotoModel>> searchPhotos(String keyword) async {
    final response = await _apiService.fetchPhotosByKeyword(keyword);
    if (response != null) {
      return response.map((json) => TourApiPhotoModel.fromJson(json)).toList();
    } else {
      print('No photos found for the keyword.');
      return [];
    }
  }
}
