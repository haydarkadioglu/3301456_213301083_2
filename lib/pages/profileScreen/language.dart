import 'package:flutter/material.dart';
import 'settingPage.dart';

class LanguagesPage extends StatefulWidget {
  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  final List<String> _languages = ['Türkçe','English', 'Español', 'Deutsche', 'Français', 'Italiano'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dil Ayarları'),
      ),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final language = _languages[index];
          return Column(
            children: [
              ListTile(
                title: Text(language),
                onTap: () {
                  setState((){
                    selectedLanguage = language;
                  });
                  Navigator.pop(context);

                },
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}



class AreasPage extends StatefulWidget {
  @override
  State<AreasPage> createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> {
  final List<String> _areas = ['Türkiye','İngiltere', 'İspanya', 'Almanya', 'Fransa', 'İtalya'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bölge Ayarları'),
      ),
      body: ListView.builder(
        itemCount: _areas.length,
        itemBuilder: (context, index) {
          final area = _areas[index];
          return Column(
            children: [
              ListTile(
                title: Text(area),
                onTap: () {
                  setState((){
                    selectedArea = area;
                  });
                  Navigator.pop(context);

                },
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}


