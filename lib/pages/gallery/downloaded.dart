import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class SavedImagesScreen extends StatefulWidget {
  @override
  _SavedImagesScreenState createState() => _SavedImagesScreenState();
}

class _SavedImagesScreenState extends State<SavedImagesScreen> {
  List<File> savedImages = [];

  @override
  void initState() {
    super.initState();
    loadSavedImages();
  }

  Future<void> loadSavedImages() async {
    final directory = Directory('/storage/emulated/0/Pictures/siriusNews');
    if (await directory.exists()) {
      final images = directory.listSync();
      setState(() {
        savedImages = images.whereType<File>().toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kaydedilen Görseller'),
      ),
      body: savedImages.isNotEmpty
          ? GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        children: savedImages.map((file) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullScreenImage(imageFile: file),
                ),
              );
            },
            child: Column(
              children: [
                Expanded(
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  file.path.split('/').last,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }).toList(),
      )
          : Center(
        child: Text('Kaydedilen görsel bulunamadı.'),
      ),
    );
  }
}


class FullScreenImage extends StatefulWidget {
  final File imageFile;

  const FullScreenImage({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool _storagePermissionGranted = false;
  String fileName = '';
  var imageFile;

  @override
  void initState() {
    super.initState();
    fileName = widget.imageFile.path.split('/').last;

  }



  void _renameImage() async {
    final TextEditingController textEditingController =
    TextEditingController(text: fileName);

    final status = await Permission.storage.status;
    if (status.isGranted) {
      _showRenameDialog(textEditingController);
    } else {
      final result = await Permission.storage.request();
      if (result.isGranted) {
        _showRenameDialog(textEditingController);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Depolama izni reddedildi.'),
          ),
        );
      }
    }
  }

  void _showRenameDialog(TextEditingController textEditingController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fotoğrafı Yeniden Adlandır'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: 'Yeni isim girin'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {

                final newFileName = textEditingController.text.trim();
                if (newFileName.isNotEmpty) {
                  final Directory directory = Directory('/storage/emulated/0/Pictures/siriusNews');
                  final newFilePath = '${directory.path}/$newFileName';
                  widget.imageFile.copy(newFilePath).then((File newFile) {
                    widget.imageFile.delete().then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('İsim $newFileName olarak değiştirildi'),
                        ),
                      );
                      setState(() {
                        final newImageFile = newFile;
                        fileName = newFileName;

                        imageFile = newImageFile;
                      });
                    }).catchError((onError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('HATA: $onError'),
                        ),
                      );
                    });
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Yeni dosya adı boş olamaz.'),
                    ),
                  );
                }
                Navigator.of(context).pop();

                },
              child: Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }





  Future<void> _deleteImage() async {
    final bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fotoğrafı Sil'),
          content: Text('Bu fotoğrafı silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {

                widget.imageFile.delete().then((value){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });

                });
                },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );


  }

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
            icon: Icon(Icons.edit),
            onPressed: _renameImage,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteImage,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Image.file(
          widget.imageFile,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
