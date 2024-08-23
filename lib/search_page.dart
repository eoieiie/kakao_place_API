import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // .env 파일에서 환경 변수를 로드하기 위한 패키지
import 'kakao_api.dart'; // kakao_api.dart 파일을 import하여 KakaoAPI 클래스에 접근

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState(); // SearchPage의 상태를 관리하는 State를 생성
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController(); // 사용자의 입력을 관리하기 위한 텍스트 컨트롤러
  final KakaoAPI _kakaoAPI = KakaoAPI(); // KakaoAPI 클래스를 인스턴스화하여 API 요청에 사용
  List<Map<String, dynamic>> _places = []; // 검색 결과를 저장하기 위한 리스트

  Future<void> _searchPlaces() async {
    final query = _controller.text; // 사용자가 입력한 검색어를 가져옴
    if (query.isNotEmpty) {
      try {
        final places = await _kakaoAPI.searchPlaces(query); // Kakao API를 사용하여 장소를 검색
        setState(() {
          _places = places; // 검색 결과를 상태로 저장하여 화면에 표시
        });
      } catch (e) {
        print('Error: $e'); // 에러 발생 시 콘솔에 출력
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('장소 검색'), // 앱바의 제목 설정
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // 화면의 패딩 설정
        child: Column(
          children: [
            TextField(
              controller: _controller, // 텍스트필드에 텍스트 컨트롤러 연결
              decoration: InputDecoration(
                labelText: '검색어를 입력하세요', // 텍스트필드의 라벨
                suffixIcon: IconButton(
                  icon: Icon(Icons.search), // 검색 아이콘
                  onPressed: _searchPlaces, // 검색 버튼을 누르면 _searchPlaces 함수 실행
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _places.length, // 검색 결과 리스트의 아이템 개수
                itemBuilder: (context, index) {
                  final place = _places[index]; // 각 검색 결과를 가져옴
                  return ListTile(
                    title: Text(place['place_name']), // 장소 이름을 리스트 타일의 제목으로 설정
                    subtitle: Text(place['address_name']), // 장소 주소를 리스트 타일의 부제목으로 설정
                    onTap: () {
                      // 장소를 선택했을 때의 동작 정의
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceDetailPage(place: place), // 장소 세부 정보 페이지로 이동
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceDetailPage extends StatelessWidget {
  final Map<String, dynamic> place; // 이전 화면에서 전달된 장소 정보를 저장하는 변수

  PlaceDetailPage({required this.place}); // 생성자에서 필수 인자로 place를 받음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place['place_name']), // 앱바의 제목을 장소 이름으로 설정
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 화면 패딩 설정
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 컨텐츠를 왼쪽 정렬
            children: [
              Text(
                '장소 정보',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // '장소 정보' 텍스트 스타일 설정
              ),
              SizedBox(height: 10), // 공간 추가
              Text(
                'JSON 정보:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // 'JSON 정보' 텍스트 스타일 설정
              ),
              SizedBox(height: 10), // 공간 추가
              Text(
                place.toString(), // 장소 정보를 JSON 형식으로 출력
                style: TextStyle(fontSize: 14), // 텍스트 스타일 설정
              ),
              SizedBox(height: 20), // 공간 추가
              Text(
                '세부 정보:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // '세부 정보' 텍스트 스타일 설정
              ),
              SizedBox(height: 10), // 공간 추가
              // JSON 키-값 쌍을 순서대로 출력하는 부분
              ...place.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0), // 각 키-값 쌍에 대한 패딩 설정
                  child: Text(
                    '${entry.key}: ${entry.value}', // 키와 값을 텍스트로 출력
                    style: TextStyle(fontSize: 14), // 텍스트 스타일 설정
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

void main() async {
  await dotenv.load(); // 환경 변수를 로드합니다.
  runApp(MaterialApp(
    home: SearchPage(), // 메인 화면을 SearchPage로 설정
  ));
}
