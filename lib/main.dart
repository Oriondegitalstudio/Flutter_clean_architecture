import 'package:clock_store_app/app.dart';
import 'package:flutter/material.dart';
import 'core/di/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const App());
}
