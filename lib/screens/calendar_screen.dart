import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/providers/task_providers.dart';
import 'package:to_do_app/widgets/calendar_header.dart';
import 'package:to_do_app/widgets/calendar_view.dart';
import 'package:to_do_app/widgets/selected_day_task_list.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<TaskModel> _getTasksForDay(DateTime day, List<TaskModel> allTasks) {
    return allTasks.where((task) => isSameDay(task.date, day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final taskProvider = Provider.of<TaskProviders>(context);
    final allTasks = taskProvider.tasks;
    final selectedDayTasks = _getTasksForDay(_selectedDay!, allTasks);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const CalendarHeader(),
          CalendarView(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay!,
            calendarFormat: _calendarFormat,
            allTasks: allTasks,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) => setState(() {
              _calendarFormat = format;
            }),
            onPageChanged: (focusedDay) => _focusedDay = focusedDay,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SelectedDayTaskList(
              selectedDay: _selectedDay!,
              selectedDayTasks: selectedDayTasks,
              isDark: isDark,
              taskProvider: taskProvider,
            ),
          ),
        ],
      ),
    );
  }
}
