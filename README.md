<pre>
lib/
│
├── models/
│   └── place_model.dart       // 장소에 대한 데이터 모델
│
├── viewmodels/
│   └── place_view_model.dart  // 비즈니스 로직과 UI를 연결하는 뷰모델
│
├── views/
│   ├── search_page.dart       // 검색 페이지 UI
│   └── place_detail_page.dart // 장소 세부 정보 페이지 UI
│
├── services/
│   └── kakao_api.dart         // Kakao API 호출 로직을 담당하는 서비스
│
└── main.dart                  // 앱의 진입점
</pre>


1. **models/place_model.dart**
   - 애플리케이션에서 사용하는 데이터 모델들이 위치해 있음.
   - `place_model.dart`는 장소에 대한 데이터를 나타내며, JSON 데이터를 객체로 변환하는 `fromJson` 메서드와 객체를 JSON으로 변환하는 `toJson` 메서드를 포함하고 있음.
   - **주의사항:**
     - 모델 클래스는 데이터 구조가 변경될 때만 수정해야 함. (예: API 응답 데이터에 새로운 필드가 추가되거나 삭제될 때)
     - UI 변경과는 직접적인 관계가 없으므로, UI가 바뀌어도 이 파일은 일반적으로 수정하지 않음.

2. **viewmodels/place_view_model.dart**
   - 비즈니스 로직과 UI 간의 연결을 담당함.
   - `PlaceModel` 데이터를 처리하고, UI에 표시할 데이터를 준비하며, API 호출 및 데이터 변환 로직을 관리함.
   - UI의 요구 사항이 변경되거나, 새로운 비즈니스 로직이 추가될 때 이 파일을 수정해야 함.

3. **views/search_page.dart, place_detail_page.dart**
   - UI 컴포넌트들임.
   - `search_page.dart`는 검색 화면을, `place_detail_page.dart`는 장소의 세부 정보를 보여주는 화면을 담당함.
   - UI와 관련된 로직은 가능한 한 `viewmodels` 폴더에 위치한 뷰모델로 옮기고, 뷰에서 데이터를 처리하는 로직을 최소화하는 것이 좋음.

4. **services/kakao_api.dart**
   - 외부 API와의 통신, 즉 Kakao API를 호출하여 데이터를 가져오는 로직을 구현함.
   - API에서 제공하는 데이터 구조가 변경될 경우 `models`와 `viewmodels` 파일도 함께 수정해야 함.
