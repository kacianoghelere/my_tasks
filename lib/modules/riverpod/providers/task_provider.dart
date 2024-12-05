import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:my_tasks/models/task_model.dart';
import 'package:my_tasks/repositories/task_repository.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError();
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final isar = ref.watch(isarProvider);

  return TaskRepository(isar);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  final TaskRepository repository;

  TaskNotifier(this.repository) : super([]);

  Future<void> loadTasks() async {
    state = await repository.getAllTasks();
  }

  Future<void> addTask(Task task) async {
    await repository.addTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await repository.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await repository.deleteTask(task);
    await loadTasks();
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);

  return TaskNotifier(repository)..loadTasks();
});

final completedTasksCountProvider = Provider<int>((ref) {
  final tasks = ref.watch(taskProvider);

  return tasks.where((task) => task.isCompleted).length;
});

final pendingTasksCountProvider = Provider<int>((ref) {
  final tasks = ref.watch(taskProvider);

  return tasks.where((task) => !task.isCompleted).length;
});
