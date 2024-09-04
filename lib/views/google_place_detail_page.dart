import 'package:flutter/material.dart';
import '../models/google_place_model.dart'; // GooglePlaceModel 클래스 임포트

class GooglePlaceDetailPage extends StatelessWidget {
  final GooglePlaceModel place;

  GooglePlaceDetailPage({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('장소 정보', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('장소 이름: ${place.name}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text('주소: ${place.address}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              if (place.rating != null)
                Text('평점: ${place.rating}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              if (place.isOpenNow != null)
                Text('현재 영업 중: ${place.isOpenNow! ? "Yes" : "No"}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              if (place.currentOpeningHours != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('영업시간:', style: TextStyle(fontSize: 16)),
                    ...place.currentOpeningHours!.map((hour) => Text(hour, style: TextStyle(fontSize: 16))),
                  ],
                ),
              SizedBox(height: 10),
              if (place.phoneNumber != null)
                Text('전화번호: ${place.phoneNumber}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              if (place.website != null)
                Text('웹사이트: ${place.website}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              if (place.latitude != null)
                Text('위도: ${place.latitude}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              if (place.longitude != null)
                Text('경도: ${place.longitude}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              if (place.reviews != null && place.reviews!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('리뷰:', style: TextStyle(fontSize: 16)),
                    ...place.reviews!.map((review) => Text(review, style: TextStyle(fontSize: 16))),
                  ],
                ),
              SizedBox(height: 10),
              if (place.types != null && place.types!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('장소 유형:', style: TextStyle(fontSize: 16)),
                    ...place.types!.map((type) => Text(type, style: TextStyle(fontSize: 16))),
                  ],
                ),
              SizedBox(height: 10),
              if (place.photoUrls != null && place.photoUrls!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('사진:', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: place.photoUrls?.length ?? 0,
                      itemBuilder: (context, index) {
                        final photoUrl = place.photoUrls![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Image.network(photoUrl),
                        );
                      },
                    ),
                  ],
                )
              else
                Text('사진이 없습니다.', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
