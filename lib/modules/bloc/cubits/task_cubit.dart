import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/models/task_model.dart';
import 'package:my_tasks/modules/bloc/cubits/task_state.dart';
import 'package:my_tasks/repositories/task_repository.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository repository;

  TaskCubit(this.repository) : super(TaskInitial());

  Future<void> loadTasks() async {
    final tasks = await repository.getAllTasks();
    emit(TaskLoaded(tasks));
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
