import 'package:http/http.dart' as http;
import 'dart:convert';



Future<String?> getIPaddress() async {
  var response = await http.get(Uri.parse('https://api.ipify.org/?format=json'));

  if (response.statusCode == 200) {
    // JSON yanıtından IP adresini alıyoruz
    var data = json.decode(response.body);
    var ipAddress = data['ip'];

    print('IP Adresiniz: $ipAddress');
    return ipAddress;
  } else {
    print('IP adresi alınamadı. Hata kodu: ${response.statusCode}');
    return null;
  }
}



Future<String?> getCityFromIP() async {
  String? ipAddress = await getIPaddress();
  String apiKey = 'b9a572c0077e4fa5bfbe755055bfb659';
  String url = 'https://api.ipgeolocation.io/ipgeo?apiKey=$apiKey&ip=$ipAddress';



  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      String city = data['city'];
      print(city);
      return city;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('Error: $e');
  }

  return null;
}
