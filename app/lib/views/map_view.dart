import 'package:flutter/material.dart';
import "../widgets/main_widgets.dart" as main_widgets;

class MapView extends StatefulWidget {
  const MapView({ Key? key }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child : Text("Map view"),         //_bodyOptions.elementAt(_selectedIndex),
    );
  }
}