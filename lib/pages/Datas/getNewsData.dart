import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:convert';

class CNN {

  List<String> cnnDunyaList = [
    'https://www.cnnturk.com/dunya-haberleri/'
    'https://www.cnnturk.com/dunya/almanya/',
    'https://www.cnnturk.com/dunya/amerika/',
  'https://www.cnnturk.com/dunya/azerbaycan/',
    'https://www.cnnturk.com/dunya/ingiltere/',
  'https://www.cnnturk.com/dunya/rusya/',
    'https://www.cnnturk.com/dunya/diger-haberler/'
  ];
  List<String> cnnSpor = ['https://www.cnnturk.com/spor-haberleri/',
  'https://www.cnnturk.com/spor/formula1-haberleri/',
    'https://www.cnnturk.com/spor/futbol-haberleri/',
    'https://www.cnnturk.com/spor/basketbol-haberleri/',
    'https://www.cnnturk.com/spor/nba-haberleri/',
    'https://www.cnnturk.com/spor/voleybol-haberleri/',
    'https://www.cnnturk.com/spor/motor-sporlari-haberleri/'
  ];


  Future returnDunya(int indis) async{
    if(indis>8){
      return null;
    }
    return getCNNData(cnnDunyaList[indis]);
  }
  Future returnSpor(int indis) async{
    if(indis>6){
      return null;
    }
    return getCNNData(cnnSpor[indis]);
  }

  Future<List<List<String>>> getCNNData(String Furl) async {
    var url = Uri.parse(Furl);
    var result = await http.get(url);
    var body = result.body;
    var document = parser.parse(body);
    var response =
        document.getElementsByClassName("col-12 col-md-6 col-lg-4 item ");

    List<String> titles = [];
    List<String> imgUrl = [];
    List<String> titleUrl = [];

    for (int i = 0; i < response.length; i++) {
      var item = response[i];
      var baslikEtiketi = item.querySelector('.card-title');
      var titleurl = item.querySelector('a')?.attributes['href'];

      var fotoEtiketi = item.querySelector('img');
      String? fotoUrl = fotoEtiketi?.attributes['data-src'];

      //print(baslikEtiketi!.text.trim());
      //print(fotoUrl);
      //print('https://www.cnnturk.com${titleurl!}');
      titles.add(baslikEtiketi!.text.trim());
      imgUrl.add(fotoUrl!);
      titleUrl.add('https://www.cnnturk.com${titleurl!}');
    }

    return [titles, imgUrl, titleUrl];
  }
}

Future getData(int indis) async {
  List<String?> AllTitle = [];
  List<String?> AllimgUrl = [];

  List<String?> AllTextUrl = [];

  for (int i = indis; i < indis + 1; i++) {
    List<List<String?>> AllDatas = await getBBCData2(
        "https://www.bbc.com/turkce/topics/c404v74nk56t?page=$i");
    AllTitle.addAll(AllDatas[0]);
    AllimgUrl.addAll(AllDatas[1]);
    AllTextUrl.addAll(AllDatas[2]);

    List<List<String?>> AllDatass =
        await getUzayOrgData("https://uzay.org/haberler/page/$i/");
    AllTitle.addAll(AllDatass[0]);
    AllimgUrl.addAll(AllDatass[1]);
    AllTextUrl.addAll(AllDatass[2]);

    List<List<String?>> AllDatasss = await getBeyinsizlerUzayData(
        "https://beyinsizler.net/kategori/uzay/page/$i/");
    AllTitle.addAll(AllDatasss[0]);
    AllimgUrl.addAll(AllDatasss[1]);
    AllTextUrl.addAll(AllDatasss[2]);
  }

  return [AllTitle, AllimgUrl, AllTextUrl];
}

Future getOnlyTeknolojiBBCData(int indis) async {
  List<String?> AllTitle = [];
  List<String?> AllimgUrl = [];

  List<String?> AllTextUrl = [];

  for (int i = indis; i < indis + 1; i++) {
    List<List<String?>> AllDatas = await getBBCData2(
        "https://www.bbc.com/turkce/topics/c2dwqnwkvnqt?page=$i");
    AllTitle.addAll(AllDatas[0]);
    AllimgUrl.addAll(AllDatas[1]);
    AllTextUrl.addAll(AllDatas[2]);
  }

  return [AllTitle, AllimgUrl, AllTextUrl];
}

Future getOnlySaglikBBCData(int indis) async {
  List<String?> AllTitle = [];
  List<String?> AllimgUrl = [];

  List<String?> AllTextUrl = [];

  for (int i = indis; i < indis + 1; i++) {
    List<List<String?>> AllDatas = await getBBCData2(
        "https://www.bbc.com/turkce/topics/cnq68n6wgzdt?page=$i");
    AllTitle.addAll(AllDatas[0]);
    AllimgUrl.addAll(AllDatas[1]);
    AllTextUrl.addAll(AllDatas[2]);
  }

  return [AllTitle, AllimgUrl, AllTextUrl];
}

Future getOnlyEkonomiBBCData(int indis) async {
  List<String?> AllTitle = [];
  List<String?> AllimgUrl = [];

  List<String?> AllTextUrl = [];

  for (int i = indis; i < indis + 1; i++) {
    List<List<String?>> AllDatas = await getBBCData2(
        "https://www.bbc.com/turkce/topics/cg726y2k82dt?page=$i");
    AllTitle.addAll(AllDatas[0]);
    AllimgUrl.addAll(AllDatas[1]);
    AllTextUrl.addAll(AllDatas[2]);
  }

  return [AllTitle, AllimgUrl, AllTextUrl];
}

Future<List<List<String>>> getBBCData2(String Furl) async {
  var url = Uri.parse(Furl);
  var result = await http.get(url);
  var body = result.body;
  var document = parser.parse(body);
  var response = document.getElementsByClassName("bbc-t44f9r");

  List<String> titles = [];
  List<String> imgUrl = [];
  List<String> titleUrl = [];

  for (int i = 0; i < response.length; i++) {
    var item = response[i];
    var baslikEtiketi = item.querySelector('.bbc-1slyjq2.e47bds20');
    String? titleurl = baslikEtiketi?.querySelector('a')?.attributes['href'];

    var fotoEtiketi = item.querySelector('.bbc-1uwua2r');
    String? fotoUrl = fotoEtiketi?.attributes['src'];

    titles.add(baslikEtiketi!.text.trim());
    imgUrl.add(fotoUrl!);
    titleUrl.add(titleurl!);
  }

  return [titles, imgUrl, titleUrl];
}

Future getOnlyBeyinsizlerData(int indis) async {
  List<String?> AllTitle = [];
  List<String?> AllimgUrl = [];

  List<String?> AllTextUrl = [];

  for (int i = indis; i < indis + 1; i++) {
    List<List<String?>> AllDatasss = await getBeyinsizlerUzayData(
        "https://beyinsizler.net/kategori/uzay/page/$i/");
    AllTitle.addAll(AllDatasss[0]);
    AllimgUrl.addAll(AllDatasss[1]);
    AllTextUrl.addAll(AllDatasss[2]);
  }

  return [AllTitle, AllimgUrl, AllTextUrl];
}

Future getBeyinsizlerUzayData(var Furl) async {
  var url, result, response, body, document, data;
  List<String> titles = [];
  List<String> imgUrl = [];
  List<String> titleUrl = [];

  url = Uri.parse(Furl);
  result = await http.get(url);
  body = result.body;
  document = parser.parse(body);

  response =
      document.getElementsByClassName("g1-gamma g1-gamma-1st entry-title");

  for (int i = 0; i < 10; i++) {
    var _titurl = response[i].querySelector('a').attributes['href'];

    var _title = response[i].text;

    titles.add(_title);
    imgUrl.add("NULL");
    titleUrl.add(_titurl);
  }

  return [titles, imgUrl, titleUrl];
}

Future getUzayOrgData(var Furl) async {
  var url, result, response, body, document, data;
  List<String> titles = [];
  List<String> imgUrl = [];
  List<String> titleUrl = [];

  url = Uri.parse(Furl);
  result = await http.get(url);
  body = result.body;
  document = parser.parse(body);

  response = document.getElementsByClassName("td-module-thumb");

  for (int i = 0; i < 7; i++) {
    if (i != 0 && i != 1) {
      String _titlee = response[i].children[0].attributes["title"];
      String _imgUrll =
          response[i].children[0].children[0].attributes["data-img-url"];
      String _titleUrl = response[i].children[0].attributes["href"];

      titles.add(_titlee);
      imgUrl.add(_imgUrll);
      titleUrl.add(_titleUrl);
    }
  }

  return [titles, imgUrl, titleUrl];
}
