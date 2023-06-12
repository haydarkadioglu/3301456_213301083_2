import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;



Future<List<String>> getImages(int indis) async {
  var url =
      'https://skyandtelescope.org/communities/online-gallery/page/$indis/';
  var response = await http.get(Uri.parse(url));
  var document = parser.parse(response.body);

  List<String> images = [];
  var elements = document.getElementsByClassName("img-fluid");

  for (int i = 0; i < 19; i++) {
    images.add(elements[i].attributes["src"].toString());
  }

  return images;
}

//access keyt eY_E_fjeTrhBgzkd14owi5Nb1QpizlEBUGCP8HiSbGU
//secret JqhV0cmcHq17W3LPvLgi1LUr8ron9S_uVbpUCmxyVXM

Future<List<String>> fetchPhotos(String query) async {
  String accessKey = 'eY_E_fjeTrhBgzkd14owi5Nb1QpizlEBUGCP8HiSbGU';
  List<String> imgUrl = [];
  final String apiUrl =
      'https://api.unsplash.com/photos/random?client_id=$accessKey&query=$query';

  for (int i = 0; i < 15; i++) {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final String photoUrl = data['urls']['regular'];
        imgUrl.add(photoUrl);
      } else {
        print('İstek başarısız oldu. Hata kodu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata oluştu: $e');
      break;
    }
  }
  return imgUrl;
}
