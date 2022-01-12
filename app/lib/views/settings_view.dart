import 'package:flutter/material.dart';
import "../widgets/main_widgets.dart" as main_widgets;
class SettingsView extends StatefulWidget {
  const SettingsView({ Key? key }) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child : Text("Settings view"),         //_bodyOptions.elementAt(_selectedIndex),
    );
  }
}