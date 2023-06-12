import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class LongTextScreen extends StatefulWidget {
  final String title;
  final String longText;
  final String imgUrl;

  const LongTextScreen({required this.title, required this.imgUrl, required this.longText});

  @override
  State<LongTextScreen> createState() => _LongTextScreenState();
}

class _LongTextScreenState extends State<LongTextScreen> {


  String filtering() {
    String _filter = widget.longText;
    List<String> metin = _filter.split(" ");
    List<int> givee = [];
    for (int i = 0; i < metin.length - 1; i++) {
      bool cont = metin[i].startsWith("<");
      if (cont) {
        givee.add(i);
      }
      bool eont = metin[i].endsWith(">");
      if (eont) {
        givee.add(i);
      }
    }
    for (int i = 0; i < givee.length; i += 2) {
      metin.removeRange(givee[i], givee[i + 1] + 1);
    }

    _filter = metin.join(" ");
    return _filter;
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            floating: true,
            snap: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            //flexibleSpace: FlexibleSpaceBar(
            //  background: CachedNetworkImage(
            //    imageUrl: widget.imgUrl,
            //    placeholder: (context, url) =>
            //        CircularProgressIndicator(),
            //    errorWidget: (context, url, error) =>
            //        Icon(Icons.error),
            //  ),
            //),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [

                Container(child: CachedNetworkImage(
                  imageUrl: widget.imgUrl,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                ),),
                Container(child: Text(widget.title,style: GoogleFonts.playfairDisplay(fontSize: 25,decorationThickness: 45),),),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.longText,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
