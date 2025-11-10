import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oops_list/models/task_model.dart';
import 'package:oops_list/providers/task_providers.dart';
import 'package:oops_list/widgets/header_section.dart';
import 'package:oops_list/widgets/filter_chips_row.dart';
import 'package:oops_list/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedFilter = 'All';

  List<TaskModel> _filterTasks(List<TaskModel> tasks) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (_selectedFilter) {
      case 'Today':
        return tasks.where((task) {
          final taskDate = DateTime(
            task.date.year,
            task.date.month,
            task.date.day,
          );
          return taskDate.isAtSameMomentAs(today);
        }).toList();
      case 'Upcoming':
        return tasks.where((task) {
          final taskDate = DateTime(
            task.date.year,
            task.date.month,
            task.date.day,
          );
          return taskDate.isAfter(today);
        }).toList();
      case 'Overdue':
        return tasks.where((task) {
          final taskDate = DateTime(
            task.date.year,
            task.date.month,
            task.date.day,
          );
          return taskDate.isBefore(today) && !task.isCompleted;
        }).toList();
      case 'Completed':
        return tasks.where((task) => task.isCompleted).toList();
      default:
        return tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProviders>(context);
    final allTasks = taskProvider.tasks;
    final filteredTasks = _filterTasks(allTasks);

    final completedCount = allTasks.where((t) => t.isCompleted).length;
    final totalCount = allTasks.length;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Oops!List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Column(
        children: [
          HeaderSection(completedCount: completedCount, totalCount: totalCount),
          FilterChipsRow(
            selectedFilter: _selectedFilter,
            onFilterChanged: (filter) =>
                setState(() => _selectedFilter = filter),
          ),
          Expanded(
            child: TaskList(
              tasks: filteredTasks,
              selectedFilter: _selectedFilter,
              onDelete: (task) => taskProvider.deleteTask(task),
              onToggle: (task) => taskProvider.toggleComplete(task),
            ),
          ),
        ],
      ),
    );
  }
}
