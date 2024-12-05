import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/modules/bloc/cubits/task_cubit.dart';
import 'package:my_tasks/modules/bloc/cubits/task_state.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stats')),
      body: Center(
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is TaskLoaded) {
              return Column(
                children: [
                  Text('Tarefas pendentes: ${state.pendingCount}'),
                  Text('Tarefas concluídas: ${state.completedCount}'),
                ],
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
