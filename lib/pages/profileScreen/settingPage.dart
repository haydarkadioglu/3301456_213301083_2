import 'package:flutter/material.dart';

import '../bottomNavigator.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Genel Ayarlar',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
            Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                title: Text(
                  "Daha Fazla Bilgi İçin Tıkla",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text("Genel Bilgiler"),
                    content: Text(
                        "Github hesabım: https://github.com/haydarkadioglu"),
                    actions: [
                      TextButton(
                        child: Text("Kapat"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
