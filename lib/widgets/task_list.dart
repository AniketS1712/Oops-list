import 'package:flutter/material.dart';
import 'package:oops_list/models/task_model.dart';
import 'task_tile.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  final String selectedFilter;
  final Function(TaskModel) onDelete;
  final Function(TaskModel) onToggle;

  const TaskList({
    super.key,
    required this.tasks,
    required this.selectedFilter,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color: theme.colorScheme.onBackground.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              selectedFilter == 'All'
                  ? "🤷‍♂️ Nothing to see here!"
                  : "No ${selectedFilter.toLowerCase()} tasks",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Add a task before I start judging you.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      physics: const BouncingScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTile(task: task, onDelete: onDelete, onToggle: onToggle);
      },
    );
  }
}
