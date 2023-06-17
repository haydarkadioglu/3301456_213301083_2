import 'package:flutter/material.dart';
import '../pages/profileScreen/loginPage.dart';
import '../pages/profileScreen/profilePage.dart';
import 'homeScreen/homepage.dart';
import 'profileScreen/enterMenu.dart';
import 'gallery/GalleryPage.dart';
import 'category/category.dart';
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
            backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
            backgroundColor: Colors.red,
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


