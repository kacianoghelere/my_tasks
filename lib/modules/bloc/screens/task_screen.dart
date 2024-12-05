import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/models/task_model.dart';
import 'package:my_tasks/modules/bloc/cubits/task_cubit.dart';
import 'package:my_tasks/modules/bloc/cubits/task_state.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      taskCubit.updateTask(task..isCompleted = value!);
                    },
                  ),
                  onLongPress: () => taskCubit.deleteTask(task),
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Adicionar Tarefa'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              final title = controller.text.trim();

              if (title.isNotEmpty) {
                taskCubit.addTask(Task(title: title));
              }

              Navigator.of(context).pop();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
