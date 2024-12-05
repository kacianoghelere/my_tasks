import 'package:equatable/equatable.dart';
import 'package:my_tasks/models/task_model.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);

  int get completedCount => tasks.where((task) => task.isCompleted).length;

  int get pendingCount => tasks.where((task) => !task.isCompleted).length;

  @override
  List<Object?> get props => [tasks];
}
