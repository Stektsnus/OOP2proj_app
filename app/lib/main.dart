import 'package:app/models/user_model.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "package:provider/provider.dart";
import "package:location/location.dart";

// Local files
import "views/create_user_view.dart" as create_user_view;
import "views/login_view.dart" as login_view;
import "views/home_view.dart" as home_view;
import "views/map_view.dart" as map_view;
import "views/settings_view.dart" as settings_view;
import "helpers/globals.dart" as globals;
import "widgets/main_widgets.dart" as main_widgets;
import "helpers/notifiers.dart" as notifiers;
import "models/user_model.dart" as user_model;
import "models/location_model.dart";

String dataBaseUrl = "http://10.0.2.2:3000/";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
      theme: ThemeData.dark(),
    );
  }
}

class MainView extends StatefulWidget {
  final user_model.User? user = user_model.User();

  MainView({Key? key}) : super(key: key) {
    user?.username = "stektsnuskingen2";
    user?.isLoggedIn = true;
    if (user?.username != null) {
      user?.isLoggedIn = true;
    }
  }
  
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  void userLoggedIn(String username) async {
    print("Callback function called");
    setState(() async {
      widget.user?.username = username;
      widget.user?.isLoggedIn = true;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print("Selected index: " + _selectedIndex.toString());
    });
  }
  Widget getAppView (User? user) {
    switch (_selectedIndex) {
      case 0:
        return const home_view.HomeView();
      case 1:
        return map_view.MapView(user : user);
      case 2:
        return const settings_view.SettingsView();
      default:
        return const Text("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user != null && widget.user?.isLoggedIn == true) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: const Text(
              "Home",
              style: TextStyle(
                  color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        body: getAppView(widget.user),
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
            backgroundColor: Colors.black54),
      );
    } else {
      return login_view.LoginView(loginCallback: userLoggedIn);
    }
  }
}
