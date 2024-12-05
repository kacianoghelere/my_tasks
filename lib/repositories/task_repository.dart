import 'package:isar/isar.dart';
import 'package:my_tasks/models/task_model.dart';

class TaskRepository {
  final Isar isar;

  TaskRepository(this.isar);

  Future<List<Task>> getAllTasks() async {
    return await isar.tasks.where().findAll();
  }

  Future<void> addTask(Task task) async {
    await isar.writeTxn(() async {
      await isar.tasks.put(task);
    });
  }

  Future<void> updateTask(Task task) async {
    await isar.writeTxn(() async {
      await isar.tasks.put(task);
    });
  }

  Future<void> deleteTask(Task task) async {
    await isar.writeTxn(() async {
      await isar.tasks.delete(task.id);
    });
  }
}
