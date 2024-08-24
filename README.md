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


1. models/place_model.dart
   애플리케이션에서 사용하는 데이터 모델들이 위치
   place_model.dart는 장소에 대한 데이터를 나타내며, JSON 데이터를 객체로 변환하는 fromJson 메서드와 객체를 JSON으로 변환하는 toJson 메서드 포함
   주의사항:
   모델 클래스는 데이터 구조가 변경될 때만 수정.(API 응답 데이터에 새로운 필드가 추가되거나 삭제될 때)
   UI 변경과는 직접적인 관계가 없으므로, UI가 바뀌어도 이 파일은 일반적으로 건드리지 않음.

2. viewmodels/
   파일: place_view_model.dart
   역할:
   비즈니스 로직과 UI 간의 연결을 담당합니다.
   PlaceViewModel은 PlaceModel 데이터를 처리하고, UI에 표시할 데이터를 준비합니다.
   또한, API 호출 및 데이터 변환 로직을 관리합니다.
   변경 시 주의사항:
   UI의 요구 사항이 변경되거나, 새로운 비즈니스 로직이 추가될 때 이 파일을 수정해야 할 수 있습니다.
   UI가 변경되면, UI에서 필요한 데이터나 상태를 이 뷰모델에서 처리하는지 확인하고, 필요한 경우 이 파일을 업데이트합니다.

3. views/
   파일들: search_page.dart, place_detail_page.dart
   역할:
   이 폴더는 UI 컴포넌트들이 위치합니다.
   search_page.dart는 검색 화면을, place_detail_page.dart는 장소의 세부 정보를 보여주는 화면을 담당합니다.
   변경 시 주의사항:
   UI가 변경될 때는 이 폴더의 파일들을 수정하게 됩니다. 예를 들어, 디자인이 변경되거나, 새로운 UI 요소가 추가될 때 이 파일들을 업데이트합니다.
   UI와 관련된 로직은 가능한 한 viewmodels 폴더에 위치한 뷰모델로 옮기고, 뷰에서 데이터를 처리하는 로직을 최소화하는 것이 좋습니다.

4. services/
   파일: kakao_api.dart
   역할:
   외부 API와의 통신을 담당합니다.
   kakao_api.dart는 Kakao API를 호출하여 데이터를 가져오는 로직을 포함합니다.
   변경 시 주의사항:
   API 사양이 변경되거나, 다른 API를 사용할 필요가 있을 때 이 파일을 수정합니다.
   UI 변경과는 직접적인 관계가 없지만, API에서 제공하는 데이터 구조가 변경될 경우 models와 viewmodels 파일도 함께 수정해야 할 수 있습니다.

5. main.dart
   파일: main.dart
   역할:
   앱의 진입점으로, 앱의 초기 설정과 초기화 작업을 처리합니다.
   앱의 전체적인 테마와 라우팅 설정도 이 파일에서 처리될 수 있습니다.
   변경 시 주의사항:
   앱의 전반적인 구조나 초기화 로직을 변경할 때 수정됩니다.
   UI가 변경될 때는 라우팅 관련 설정이나 테마가 변경될 수 있으므로, 이 부분을 신경 써서 업데이트해야 합니다.
   요약:
   UI가 변경될 때: views/ 폴더에 있는 파일들을 수정합니다. UI 요소에서 필요한 데이터나 상태가 변경된다면, viewmodels/ 폴더에 있는 파일들도 함께 수정할 수 있습니다.
   API 사양이 변경될 때: services/와 models/ 폴더의 파일들을 수정합니다. 데이터 처리 로직에 영향이 있다면, viewmodels/도 수정해야 할 수 있습니다.
   전체 앱 구조나 초기화 로직이 변경될 때: main.dart를 수정합니다.
   이 구조에서는 각 부분이 독립적으로 역할을 수행하므로, 특정 부분의 수정이 다른 부분에 미치는 영향을 최소화할 수 있습니다. 이를 통해 유지보수성과 확장성을 높일 수 있습니다.