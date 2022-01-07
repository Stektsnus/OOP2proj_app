import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "views/create_user_view.dart" as create_user_view;
import "views/login_view.dart" as login_view;
String dataBaseUrl = "http://10.0.2.2:3000/";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainView(),
      theme: ThemeData.dark(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool loggednIn = false;
  int _selectedIndex = 0;
  static const TextStyle _optionStyle = 
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _bodyOptions = <Widget>[
    
    const Text(
      "Index 1: xD",
      style: _optionStyle,
    ),
    const Text(
      "Index 2: Settingsview", // Lägg in nya widgets här för respektive vy ex scaffold med body
      style: _optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            "Nöd",
            style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
      ),
      body: const Center(
        child: login_view.LoginView()                         //_bodyOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        backgroundColor: Colors.black54,
      ),
    );
  }
}




