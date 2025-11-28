import 'package:flutter/material.dart';

import 'app.dart';
import 'di/dependencies.dart';

/// Development config entry point.
/// Launch with `flutter run --target lib/main_development.dart`.
/// Uses local data.
void main() {
  runApp(StarterApp(environmentName: 'Development', providers: providersLocal));
}
