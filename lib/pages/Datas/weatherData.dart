import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';



Future getWeather(String city) async{


  var url, result, response, body, document, status, temperature;
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


