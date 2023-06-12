import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Datas/marksDB.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../webView.dart';

class markedPage extends StatefulWidget {
  const markedPage({Key? key}) : super(key: key);

  @override
  State<markedPage> createState() => _markedPageState();
}

class _markedPageState extends State<markedPage> {
  final dbHelper = DatabaseHelper();


  List<Map<String, dynamic>> _dataList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final dataList = await dbHelper.getData();
    setState(() {
      _dataList = dataList;
    });
  }

  Future<void> _deleteData(int id) async {
    final result = await dbHelper.deleteData(id);


    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kaydedilenler"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _dataList.isEmpty
        ? Center(child: Text('Kaydedilen herhangi bir öğe bulunmamaktadır.'),)
        :ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (BuildContext context, int index) {
          final data = _dataList[index];
          final id = data['id'];
          final _title = data['baslik'];
          final _url = data['metinurl'];
          final _resimurl = data['resimurl'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(texturl: _url)
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
                            imageUrl: _resimurl,
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
                            '$_title',
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
                  Divider(),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteData(id);
                    },
                  ),
                ],
              ),
            ),
          );

        },
      ),
    );
  }





}
