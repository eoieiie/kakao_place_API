import 'package:flutter/material.dart';
import '../models/google_place_model.dart';

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
              // 장소 정보 섹션 제목
              Text(
                '장소 정보',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // 장소 이름 출력
              Text('장소 이름: ${place.name}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              // 주소 출력
              Text('주소: ${place.address}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              // 평점 출력
              if (place.rating != null)
                Text('평점: ${place.rating}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              // 영업 상태 출력
              if (place.isOpenNow != null)
                Text(
                  '현재 영업 중: ${place.isOpenNow! ? "Yes" : "No"}',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 10),

              // 전화번호 출력
              if (place.phoneNumber != null)
                Text('전화번호: ${place.phoneNumber}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              // 웹사이트 출력
              if (place.website != null)
                Text('웹사이트: ${place.website}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              // 위도 출력
              if (place.latitude != null)
                Text('위도: ${place.latitude}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              // 경도 출력
              if (place.longitude != null)
                Text('경도: ${place.longitude}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              // 사진 출력
              place.photoUrls != null && place.photoUrls!.isNotEmpty
                  ? Column(
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
                  : Text('사진이 없습니다.', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
