import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tasks/models/task_model.dart';
import 'package:my_tasks/modules/riverpod/providers/task_provider.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    final taskNotifier = ref.read(taskProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciador de Tarefas')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                taskNotifier.updateTask(task..isCompleted = value!);
              },
            ),
            onLongPress: () => taskNotifier.deleteTask(task),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, taskNotifier),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskNotifier taskNotifier) {
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
                taskNotifier.addTask(Task(title: title));
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