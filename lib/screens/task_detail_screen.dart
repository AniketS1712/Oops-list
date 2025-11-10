import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:oops_list/models/task_model.dart';
import 'package:oops_list/providers/task_providers.dart';
import 'package:oops_list/screens/edit_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final taskProvider = Provider.of<TaskProviders>(context);
    final isOverdue = task.date.isBefore(DateTime.now()) && !task.isCompleted;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Task Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EditTaskScreen(task: task)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Task'),
                  content: const Text(
                    'Finally giving up? This task will be gone forever!',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        taskProvider.deleteTask(task);
                        Navigator.pop(context); // Close dialog
                        Navigator.pop(context); // Go back to home
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Task deleted. Out of sight, out of mind! 🗑️',
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: task.isCompleted
                    ? Colors.green.withOpacity(0.1)
                    : isOverdue
                    ? Colors.red.withOpacity(0.1)
                    : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: task.isCompleted
                      ? Colors.green
                      : isOverdue
                      ? Colors.red
                      : Colors.blue,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    task.isCompleted
                        ? Icons.check_circle
                        : isOverdue
                        ? Icons.warning
                        : Icons.pending,
                    color: task.isCompleted
                        ? Colors.green
                        : isOverdue
                        ? Colors.red
                        : Colors.blue,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.isCompleted
                              ? 'Completed'
                              : isOverdue
                              ? 'Overdue'
                              : 'Pending',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: task.isCompleted
                                ? Colors.green
                                : isOverdue
                                ? Colors.red
                                : Colors.blue,
                          ),
                        ),
                        Text(
                          task.isCompleted
                              ? 'Wow, you actually did it!'
                              : isOverdue
                              ? 'This was supposed to be done already 😬'
                              : 'Better get started soon!',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: task.isCompleted,
                    onChanged: (_) {
                      taskProvider.toggleComplete(task);
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Title Section
            Text(
              'Title',
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                task.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Description Section
            Text(
              'Description',
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                task.description.isEmpty
                    ? 'No description provided'
                    : task.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: task.description.isEmpty
                      ? theme.colorScheme.onSurface.withOpacity(0.5)
                      : theme.colorScheme.onSurface,
                  fontStyle: task.description.isEmpty ? FontStyle.italic : null,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Date Information
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    icon: Icons.calendar_today,
                    label: 'Due Date',
                    value: DateFormat('MMM dd, yyyy').format(task.date),
                    color: isOverdue ? Colors.red : Colors.blue,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoCard(
                    icon: Icons.access_time,
                    label: 'Created',
                    value: DateFormat('MMM dd').format(task.createdAt),
                    color: Colors.purple,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Time until due
            if (!task.isCompleted) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.hourglass_bottom, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time Remaining',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                            ),
                          ),
                          Text(
                            _getTimeRemaining(task.date),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isOverdue ? Colors.red : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getTimeRemaining(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now);

    if (difference.isNegative) {
      final days = difference.inDays.abs();
      return days == 0
          ? 'Overdue by today'
          : 'Overdue by $days day${days > 1 ? 's' : ''}';
    }

    if (difference.inDays == 0) {
      return 'Due today!';
    } else if (difference.inDays == 1) {
      return 'Due tomorrow';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days left';
    } else {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} left';
    }
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
