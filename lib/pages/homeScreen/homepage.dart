import 'package:flutter/material.dart';
import '../Datas/getNewsData.dart';
import 'Drawer.dart';
import '../Datas/marksDB.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './searchPage.dart';
import 'markedPage.dart';
import 'package:path/path.dart';
import '../webView.dart';



List<String?> TitlesData = [];
List<String?> ImagesData = [];
List<String?> TitlesUrl = [];
List<String?> TextsData = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _CardList = [];
  int indis = 2;

  bool isLoading = false;
  List<bool> marks = [];
  bool marked = false;

  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _dataList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _doldur(indis);
    marks = List.generate(TitlesData.length, (index) => false);
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


  Future _doldur(int _indis) async {
    List<List<String?>> Datas = await getData(_indis);
    setState(() {
      TitlesData.addAll(Datas[0]);
      ImagesData.addAll(Datas[1]);
      TitlesUrl.addAll(Datas[2]);
      marks = List.generate(TitlesData.length, (index) => false);
    });
  }

  Future<void> _getData() async {
    final dataList = await dbHelper.getData();
    setState(() {
      _dataList = dataList;
    });

  }



  Future<void> _save(int _takeCou) async{
    final result = await dbHelper.insertData(TitlesData[_takeCou]!, ImagesData[_takeCou]!, TitlesUrl[_takeCou]!);
    _getData();
  }

  Future<void> _deleteData(int id) async {
    final result = await dbHelper.deleteData(id);


    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(

          actions: [
            IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => markedPage()
                ),
              );
            }, icon: Icon(Icons.library_books)),
            TitlesData.isEmpty
              ?Icon(Icons.search)
              :IconButton(icon: Icon(Icons.search),onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage()
              ),
            );
          }),],
          backgroundColor: Colors.teal,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Haberler',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lobster',
            ),
          ),
        ),
        drawer: DrawerPage(),
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
            : ListView.builder(
          itemCount: TitlesData.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == TitlesData.length) {
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
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => WebViewScreen(texturl: TitlesUrl[index]!),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );

              },
              child: Card(
                shadowColor: Colors.teal,
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
              context as BuildContext,PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => WebViewScreen(texturl: TitlesUrl[index]!),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
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

              ],
            ),
          ),
        ),
      );
    }
    return cardList;
  }
}

