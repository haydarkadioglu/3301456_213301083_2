import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:async';



Future getWeather(String city) async{


  var url, result, body, document, status, temperature;
  url = "https://havadurumu15gunluk.xyz/havadurumu/565/$city-hava-durumu-15-gunluk.html";

  url = Uri.parse(url);
  result = await http.get(url);
  body = result.body;
  document = parser.parse(body);

  status = document.querySelector(".status");
  //status = status.map((e) => e.text);

  temperature = document.querySelector('.temperature.type-1');

  return [status.text, temperature.text];
}



Future getWeather15day(String city) async{

  List<String> date = [];
  List<String> statusWeather = [];
  List<String> daytime = [];
  List<String> night = [];

  var url, result, body, document, status;
  url = "https://havadurumu15gunluk.xyz/havadurumu/565/$city-hava-durumu-15-gunluk.html";

  url = Uri.parse(url);
  result = await http.get(url);
  body = result.body;
  document = parser.parse(body);

  status = document.getElementsByTagName('table')[0].children[0].children;
  for(int i = 1; i<16 ; i++){
    date.add(status[i].children[0].text);
    statusWeather.add(status[i].children[1].text);
    daytime.add(status[i].children[3].text);
    night.add(status[i].children[4].text);

  }
  return [date,statusWeather,daytime,night];
}

Future getWeatherHours(String city, int indisNum) async{

  List<String> hours = [];
  List<String> statusWeather = [];
  List<String> wind = [];

  var url, result, body, document, status;
  url = "https://havadurumu15gunluk.xyz/saat-saat-havadurumu/$indisNum/565/$city-hava-durumu-saatlik.html";

  url = Uri.parse(url);
  result = await http.get(url);
  body = result.body;
  document = parser.parse(body);

  status = document.getElementsByTagName('table')[0].children[0].children;

  for(int i = 1; i<24 ; i++){
    try{

    hours.add(status[i].children[0].text);
    statusWeather.add(status[i].children[1].text);
    wind.add(status[i].children[5].text);

    }catch(e){
      break;
    }
  }
  return [hours,statusWeather,wind];
}


