import "package:flutter/material.dart";

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
  
  int _selectedIndex = 0;
  static const TextStyle _optionStyle = 
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _bodyOptions = <Widget>[
    Container(
      child: Column(
        children: [
          const Text(
            "Index 0: Homeview",
        )],
      ),
    ),
    const Text(
      "Index 1: Mapview",
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
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.right,
          ),
        ),
      ),
      body: Center(
        child: _bodyOptions.elementAt(_selectedIndex),
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

      ), // TIPS: KLICKA CTRL + SPACE FÖR ALTERNATIV I WIDGETS
    );
  }
}
