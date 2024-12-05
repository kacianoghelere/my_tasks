import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:my_tasks/commons/screens/main_screen.dart';
import 'package:my_tasks/models/task_model.dart';
import 'package:my_tasks/modules/bloc/cubits/task_cubit.dart';
import 'package:my_tasks/modules/bloc/screens/stats_screen.dart';
import 'package:my_tasks/modules/bloc/screens/task_screen.dart';
import 'package:my_tasks/repositories/task_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open([TaskSchema], directory: dir.path);

  final taskRepository = TaskRepository(isar);

  runApp(MyApp(repository: taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepository repository;

  const MyApp({super.key, required this.repository});

  static const List<Widget> _screens = <Widget>[
    TaskScreen(),
    StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => TaskCubit(repository)..loadTasks(),
        child: MainScreen(screens: _screens),
      ),
    );
  }
}

