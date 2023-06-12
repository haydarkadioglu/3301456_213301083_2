import 'package:flutter/material.dart';
import 'package:sirius/pages/homeScreen/Drawer.dart';
import './pages/bottomNavigator.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeSettings themeSettings = ThemeSettings();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: themeSettings.returnTheme(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: BottomNavigation(),
      ),
    );
  }
}


