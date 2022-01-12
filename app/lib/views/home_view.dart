import 'package:flutter/material.dart';
import "../widgets/main_widgets.dart" as main_widgets;

class HomeView extends StatefulWidget {
  final String title = "Home";
  const HomeView({ Key? key }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child : Text("Home view"),         //_bodyOptions.elementAt(_selectedIndex),
    );
  }
}