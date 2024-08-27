class TourApiPhotoModel {
  final String galTitle;
  final String galWebImageUrl;
  final String? galPhotographyLocation;

  TourApiPhotoModel({
    required this.galTitle,
    required this.galWebImageUrl,
    this.galPhotographyLocation,
  });

  factory TourApiPhotoModel.fromJson(Map<String, dynamic> json) {
    return TourApiPhotoModel(
      galTitle: json['galTitle'],
      galWebImageUrl: json['galWebImageUrl'],
      galPhotographyLocation: json['galPhotographyLocation'],
    );
  }
}
