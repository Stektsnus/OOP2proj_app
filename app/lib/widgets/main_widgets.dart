import 'package:flutter/material.dart';
import "../helpers/notifiers.dart" as notifiers;

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({ Key? key }) : super(key: key);

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print("Selected index: " + _selectedIndex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "Map",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.red,
      iconSize: 30,
      onTap: _onItemTapped,
      backgroundColor: Colors.black54
    );
  }
}