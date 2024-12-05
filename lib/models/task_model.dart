import 'package:isar/isar.dart';

part 'task_model.g.dart';

@Collection()
class Task {
  Id id = Isar.autoIncrement; // Gerado automaticamente
  late String title;
  bool isCompleted = false;

  Task({required this.title, this.isCompleted = false});
}
