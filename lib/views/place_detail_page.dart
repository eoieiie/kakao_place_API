import 'package:flutter/material.dart';
import '../models/place_model.dart'; // PlaceModel 클래스를 임포트하여 장소 데이터 모델을 사용.

class PlaceDetailPage extends StatelessWidget {
  final PlaceModel place; // PlaceModel 인스턴스를 저장하는 변수

  PlaceDetailPage({required this.place}); // 필수 인자로 PlaceModel을 받는 생성자

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.placeName), // 앱바의 제목을 장소 이름으로 설정
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 화면 패딩 설정
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 컨텐츠를 왼쪽 정렬
            children: [
              Text(
                '장소 정보', // 섹션 제목
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // 텍스트 스타일 설정
              ),
              SizedBox(height: 10), // 위아래 공간 추가

              // 각 필드에 접근하여 필요한 정보만 출력하도록(나중에 너네들 보기 쉬우라고)
              Text('장소 이름: ${place.placeName}', style: TextStyle(fontSize: 16)), // 장소 이름 출력
              SizedBox(height: 10), // 위아래 공간 추가

              Text('주소: ${place.addressName}', style: TextStyle(fontSize: 16)), // 주소 출력
              SizedBox(height: 10), // 위아래 공간 추가

              Text('전화번호: ${place.phone}', style: TextStyle(fontSize: 16)), // 전화번호 출력
              SizedBox(height: 10), // 위아래 공간 추가

              Text('카테고리: ${place.categoryGroupName}', style: TextStyle(fontSize: 16)), // 카테고리 그룹 이름 출력
              SizedBox(height: 10), // 위아래 공간 추가

              Text('웹사이트: ${place.placeUrl}', style: TextStyle(fontSize: 16)), // 장소 URL 출력
              SizedBox(height: 10), // 위아래 공간 추가

              Text('경도: ${place.x}', style: TextStyle(fontSize: 16)), // 경도 출력
              SizedBox(height: 10), // 위아래 공간 추가

              Text('위도: ${place.y}', style: TextStyle(fontSize: 16)), // 위도 출력
              SizedBox(height: 10), // 위아래 공간 추가

              Text('거리: ${place.distance}m', style: TextStyle(fontSize: 16)), // 거리 출력 (단위: 미터)

            ],
          ),
        ),
      ),
    );
  }
}
