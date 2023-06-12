import 'package:flutter/material.dart';
import '../pages/profileScreen/loginPage.dart';
import '../pages/profileScreen/profilePage.dart';
import 'Datas/marksDB.dart';
import 'homeScreen/homepage.dart';
import 'profileScreen/enterMenu.dart';
import 'profileScreen/createPerson.dart';
import 'profileScreen/settingPage.dart';
import 'gallery/GalleryPage.dart';
import 'test.dart';
import 'gallery/downloaded.dart';
import 'category/category.dart';
import 'homeScreen/markedPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';







class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  AxisDirection _slideAnimationDirection = AxisDirection.right;



  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoriesPage(),
    PhotoGallery(),
    ControllerClass(),
    LocationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index > _selectedIndex) {
        _selectedIndex = index;
        _slideAnimationDirection = AxisDirection.left;
      } else if (index < _selectedIndex) {
        _selectedIndex = index;
        _slideAnimationDirection = AxisDirection.right;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _widgetOptions.elementAt(_selectedIndex),
        transitionBuilder: (child, animation) {
          final direction = animation.value > 0 ? AxisDirection.left : AxisDirection.right;
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(_slideAnimationDirection == AxisDirection.left ? 1.0 : -1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),


      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Kategori',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album_outlined),
            label: 'Galeri',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ControllerClass extends StatefulWidget {
  const ControllerClass({Key? key}) : super(key: key);

  @override
  State<ControllerClass> createState() => _ControllerClassState();
}

class _ControllerClassState extends State<ControllerClass> {


  @override
  Widget build(BuildContext context) {
    return personData.isNotEmpty
        ? ProfileMenu(name: personData[0], email: personData[1],)
        : enterPage()
    ;
  }
}


class DatabaseLogin {
  static final _databaseName = 'databaseLogin.db';
  static final _databaseVersion = 1;
  static final table = 'my_table';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnEmail = 'email';
  static final columnUserID = 'userID';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _databaseName);

    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT,
        $columnEmail TEXT,
        
      )
    ''');
  }

  Future<int> insertData(String name, String email) async {
    final db = await database;

    final data = {
      columnName: name,
      columnEmail: email,
    };

    return await db.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> deleteData(int id) async {
    final db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
