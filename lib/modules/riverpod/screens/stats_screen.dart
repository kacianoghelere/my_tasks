import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tasks/modules/riverpod/providers/task_provider.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedTasksCount = ref.watch(completedTasksCountProvider);

    final pendingTasksCount = ref.watch(pendingTasksCountProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Stats')),
      body: Center(
        child: Column(
          children: [
            Text('Tarefas pendentes: $pendingTasksCount'),
            Text('Tarefas concluídas: $completedTasksCount'),
          ],
        )
      ),
    );
  }
}
