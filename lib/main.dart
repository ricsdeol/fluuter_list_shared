import 'package:flutter/material.dart';

import 'app/app_widged.dart';
import 'app/injector.dart';

void main() {
  registerDependencies();
  runApp(const AppWidged());
}
