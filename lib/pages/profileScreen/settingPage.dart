import 'package:flutter/material.dart';
import 'package:sirius/pages/profileScreen/language.dart';

String selectedLanguage = 'Türkçe';
String selectedArea = 'Türkiye';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Gece modu'),
            trailing: Switch(
              value: darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  darkModeEnabled = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Seçili dil: $selectedLanguage'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LanguagesPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Seçili Bölge: $selectedArea'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AreasPage()),
              );
            },
          ),
          Divider(),
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
                      '''Github hesabım: https://github.com/haydarkadioglu
                         \nUygylamamızı kullandığınız için teşekkür ederiz. 
                          '''),
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
    );
  }
}
