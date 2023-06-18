import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../Datas/GallaeriesData.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'downloaded.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({Key? key}) : super(key: key);

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  List<String?> imgUrl = [];
  int page = 1;
  int count = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }


  Future<void> _loadImages() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    List<String?> newImages = await getImages(page);
    List<String?> pinImages = await fetchPhotos('deepSpace');
    setState(() {
      imgUrl.addAll(pinImages);
      imgUrl.addAll(newImages);
      page++;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        centerTitle: true,
        title: Text('Fotoğraf Galerisi'),
        actions: [IconButton(icon: Icon(Icons.download_for_offline_outlined),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) => SavedImagesScreen(),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },),],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: imgUrl.length + 1,
        itemBuilder: (context, index) {
          if (index == imgUrl.length) {
            return Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _loadImages,
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
                  pageBuilder: (context, animation, secondaryAnimation) => FullScreenImage(
                    imageUrl: imgUrl[index]!,
                  ),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = 0.0;
                    var end = 1.0;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return ScaleTransition(
                      scale: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );

            },
            child: CachedNetworkImage(
              imageUrl: imgUrl[index]!,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}


class _FullScreenImageState extends State<FullScreenImage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async{
              try{

              await GallerySaver.saveImage(widget.imageUrl, albumName: 'siriusNews');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('indirme başarılı'),
                ),
              );
              }catch (e){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('indirme başarısız: $e'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl!,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
