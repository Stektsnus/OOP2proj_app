library oop2_proj_app.globals;

import 'package:flutter/material.dart';

typedef LoginCallback = void Function(String);


// Screenarguments
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}


