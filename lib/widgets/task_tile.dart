import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oops_list/models/task_model.dart';
import 'package:oops_list/screens/task_detail_screen.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final Function(TaskModel) onDelete;
  final Function(TaskModel) onToggle;

  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isOverdue = task.date.isBefore(DateTime.now()) && !task.isCompleted;

    return Dismissible(
      key: Key(task.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(task),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isOverdue
              ? Border.all(color: Colors.redAccent, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task)),
            );
          },
          leading: Checkbox(
            activeColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            value: task.isCompleted,
            onChanged: (_) => onToggle(task),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: task.isCompleted
                  ? Colors.grey
                  : theme.colorScheme.onSurface,
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  task.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 12,
                    color: isOverdue ? Colors.red : Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('MMM dd, yyyy').format(task.date),
                    style: TextStyle(
                      fontSize: 12,
                      color: isOverdue ? Colors.red : Colors.grey,
                      fontWeight: isOverdue
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: isOverdue
              ? const Icon(Icons.warning, color: Colors.red, size: 20)
              : null,
        ),
      ),
    );
  }
}
