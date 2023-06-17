import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Datas/getNewsData.dart';
import '../Datas/marksDB.dart';
import '../webView.dart';




class NewsScreen extends StatefulWidget {
  final String referans;
  const NewsScreen({required this.referans});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  CNN _cnn = CNN();

  List<String?> TitlesData = [];
  List<String?> ImagesData = [];
  List<String?> TitlesUrl = [];
  List<Widget> _CardList = [];
  bool isLoading = false;
  int indis = 1;
  List<bool> marks = [];

  bool marked = false;

  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _dataList = [];




  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _doldur(indis);
    marks = List.generate(TitlesData.length, (index) => false);
  }

  Future _doldur(int _indis) async {
    List<List<String?>> Datas = [];
    if(widget.referans == 'BBC'){
      Datas = await getData(indis);
    }
    if(widget.referans == 'TEKNOLOJİ'){
      Datas = await getOnlyTeknolojiBBCData(indis);
    }
    if(widget.referans == "SAĞLIK"){
      Datas = await getOnlySaglikBBCData(indis);
    }
    if(widget.referans == "EKONOMİ"){
      Datas = await getOnlyEkonomiBBCData(indis);
    }
    if(widget.referans == "DÜNYA"){
      Datas = await _cnn.returnDunya(indis);
    }
    if(widget.referans == "SPOR"){
      Datas = await _cnn.returnSpor(indis);
    }
    setState(() {
      TitlesData.addAll(Datas[0]);
      ImagesData.addAll(Datas[1]);

      TitlesUrl.addAll(Datas[2]);
      marks = List.generate(TitlesData.length, (index) => false);
    });

  }


  Future<void> _save(int _takeCou) async{
    final result = await dbHelper.insertData(TitlesData[_takeCou]!, ImagesData[_takeCou]!, TitlesUrl[_takeCou]!);
    _getData();
  }
  Future<void> _getData() async {
    final dataList = await dbHelper.getData();
    setState(() {
      _dataList = dataList;
    });

  }


  Future _refresh() async {


    setState(() {
      isLoading = true;

    });
    setState(() async {
      indis = indis + 1;

      await _doldur(indis);
      _CardList = _buildCardList();
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.referans),
      ),
      body: TitlesData.isEmpty
      ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Haberler yükleniyor..."),
        SizedBox(
          height: 15,
        ),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    )
      :ListView.builder(
        itemCount: TitlesData.length ,
        itemBuilder: (context, index) {
          final newsItem = TitlesData[index];
          if (index == TitlesData.length - 1) {
            return Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _refresh,
                child: Text('Daha Fazla Göster'),
              ),
            );
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context as BuildContext,
                MaterialPageRoute(
                    builder: (context) => WebViewScreen(texturl: TitlesUrl[index]!)
                ),
              );
            },
            child:Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: ImagesData[index]!,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TitlesData[index]!,
                            style: GoogleFonts.roboto(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {
                    setState(() {
                      if (marks[index]==true){
                        marks[index]=false;
                      }
                      else marks[index]=true;
                      _save(index);
                    });
                  }, icon: marks[index] == true
                      ? Icon(Icons.bookmark_add)
                      : Icon(Icons.bookmark_add_outlined)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  List<Widget> _buildCardList() {
    List<Widget> cardList = [];
    for (int index = 0; index < TitlesData.length; index++) {
      cardList.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context as BuildContext,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(texturl: TitlesUrl[index]!)
              ),
            );
          },
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: ImagesData[index]!,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TitlesData[index]!,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
                IconButton(onPressed: () {
                  setState(() {
                    if (marks[index]==true){
                      marks[index]=false;
                    }
                    else marks[index]=true;
                    _save(index);
                  });
                }, icon: marks[index] == true
                    ? Icon(Icons.bookmark_add)
                    : Icon(Icons.bookmark_add_outlined)),
              ],
            ),
          ),
        ),
      );
    }
    return cardList;
  }

}
