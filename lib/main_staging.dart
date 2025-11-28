import 'package:flutter/material.dart';

import 'app.dart';
import 'config/dependencies.dart';

/// Staging config entry point.
/// Launch with `flutter run --target lib/main_staging.dart`.
/// Uses remote data from a server.
void main() {
  runApp(StarterApp(environmentName: 'Staging', providers: providersRemote));
}
