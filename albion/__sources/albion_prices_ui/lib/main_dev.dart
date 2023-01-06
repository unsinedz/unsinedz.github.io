import 'package:albion_prices_ui/dependencies.dart';
import 'package:flutter/material.dart';

import 'widgets/app.dart';

void main() {
  registerDependencies(isDev: true);
  runApp(const MyApp());
}
