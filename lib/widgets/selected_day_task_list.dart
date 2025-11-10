import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/providers/task_providers.dart';
import 'package:to_do_app/screens/task_detail_screen.dart';
import 'package:to_do_app/widgets/empty_day_placeholder.dart';

class SelectedDayTaskList extends StatelessWidget {
  final DateTime selectedDay;
  final List<TaskModel> selectedDayTasks;
  final bool isDark;
  final TaskProviders taskProvider;

  const SelectedDayTaskList({
    super.key,
    required this.selectedDay,
    required this.selectedDayTasks,
    required this.isDark,
    required this.taskProvider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[50],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date & task count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('EEEE, MMM dd').format(selectedDay),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${selectedDayTasks.length} tasks',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Task list or empty state
          Expanded(
            child: selectedDayTasks.isEmpty
                ? const EmptyDayPlaceholder()
                : ListView.builder(
                    itemCount: selectedDayTasks.length,
                    itemBuilder: (context, index) {
                      final task = selectedDayTasks[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[850] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailScreen(task: task),
                            ),
                          ),
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (_) => taskProvider.toggleComplete(task),
                            activeColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: task.isCompleted
                                  ? Colors.grey
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          subtitle: task.description.isNotEmpty
                              ? Text(
                                  task.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                  ),
                                )
                              : null,
                          trailing: Icon(
                            Icons.chevron_right,
                            color: theme.colorScheme.onSurface.withOpacity(0.3),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
