import 'package:flutter/material.dart';
import '../viewmodels/place_view_model.dart'; // 장소 검색 로직을 처리하는 PlaceViewModel
import 'place_detail_page.dart'; // 장소 세부 정보 페이지
import '../models/place_model.dart'; // PlaceModel 클래스를 임포트하여 장소 데이터 모델을 사용

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState(); // SearchPage의 상태를 관리하는 State를 생성
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController(); // 사용자의 입력을 관리하기 위한 텍스트 컨트롤러를 생성
  final PlaceViewModel _viewModel = PlaceViewModel(); // 장소 검색 로직을 처리하는 PlaceViewModel을 인스턴스화
  List<PlaceModel> _places = []; // 검색 결과를 저장하기 위한 리스트를 초기화

  // 장소를 검색하는 메서드
  Future<void> _searchPlaces() async {
    final query = _controller.text; // 사용자가 입력한 검색어를 가져와서
    if (query.isNotEmpty) { // 검색어가 비어있지 않은 경우에만 검색 진행
      try {
        final places = await _viewModel.searchPlaces(query); // ViewModel을 통해 장소 검색을 수행
        setState(() {
          _places = places; // 검색 결과를 상태에 저장하여 UI에 반영
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
        title: Text('장소 검색'), // 앱바의 제목을 설정합니다.
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // 화면의 패딩을 설정합니다.
        child: Column(
          children: [
            TextField(
              controller: _controller, // 텍스트필드에 텍스트 컨트롤러를 연결합니다.
              decoration: InputDecoration(
                labelText: '검색어를 입력하세요', // 텍스트필드의 라벨을 설정합니다.
                suffixIcon: IconButton(
                  icon: Icon(Icons.search), // 검색 아이콘을 설정합니다.
                  onPressed: _searchPlaces, // 검색 버튼을 누르면 _searchPlaces 함수가 실행됩니다.
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _places.length, // 검색 결과 리스트의 아이템 개수를 설정합니다.
                itemBuilder: (context, index) {
                  final place = _places[index]; // 각 검색 결과를 가져옵니다.
                  return ListTile(
                    title: Text(place.placeName), // 장소 이름을 리스트 타일의 제목으로 설정합니다.
                    subtitle: Text(place.addressName), // 장소 주소를 리스트 타일의 부제목으로 설정합니다.
                    onTap: () {
                      // 장소를 선택했을 때의 동작을 정의합니다.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceDetailPage(place: place), // 선택한 장소의 세부 정보 페이지로 이동합니다.
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
