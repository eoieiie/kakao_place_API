import 'package:flutter/material.dart';
import '../viewmodels/google_place_view_model.dart';
import 'google_place_detail_page.dart';
import '../models/google_place_model.dart';

class GoogleSearchPage extends StatefulWidget {
  @override
  _GoogleSearchPageState createState() => _GoogleSearchPageState();
}

class _GoogleSearchPageState extends State<GoogleSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final GooglePlaceViewModel _viewModel = GooglePlaceViewModel();
  List<GooglePlaceModel> _places = [];

  Future<void> _searchPlaces() async {
    final query = _controller.text;
    if (query.isNotEmpty) {
      try {
        final places = await _viewModel.searchPlaces(query);
        setState(() {
          _places = places;
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Place Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter search keyword',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchPlaces,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  final place = _places[index];
                  final thumbnailUrl = place.photoUrls != null && place.photoUrls!.isNotEmpty
                      ? place.photoUrls!.first // 첫 번째 사진 URL을 썸네일로 사용
                      : null;

                  return ListTile(
                    leading: thumbnailUrl != null
                        ? Image.network(
                      thumbnailUrl,
                      width: 50, // 썸네일 너비
                      height: 50, // 썸네일 높이
                      fit: BoxFit.cover, // 이미지가 잘리더라도 썸네일 크기에 맞춤
                    )
                        : Icon(Icons.image_not_supported), // 이미지가 없을 때 대체 아이콘
                    title: Text(place.name),
                    subtitle: Text(place.address),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GooglePlaceDetailPage(place: place),
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
