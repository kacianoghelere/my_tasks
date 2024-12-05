import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:my_tasks/commons/screens/main_screen.dart';
import 'package:my_tasks/models/task_model.dart';
import 'package:my_tasks/modules/riverpod/providers/task_provider.dart';
import 'package:my_tasks/modules/riverpod/screens/stats_screen.dart';
import 'package:my_tasks/modules/riverpod/screens/task_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open([TaskSchema], directory: dir.path);

  runApp(ProviderScope(
    overrides: [
      isarProvider.overrideWithValue(isar),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const List<Widget> _screens = <Widget>[
    TaskScreen(),
    StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(screens: _screens),
    );
  }
}
