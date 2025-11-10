import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:oops_list/models/task_model.dart';

class CalendarView extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final List<TaskModel> allTasks;
  final void Function(DateTime, DateTime) onDaySelected;
  final void Function(CalendarFormat) onFormatChanged;
  final void Function(DateTime) onPageChanged;

  const CalendarView({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.allTasks,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  List<TaskModel> _getTasksForDay(DateTime day) {
    return allTasks.where((task) => isSameDay(task.date, day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TableCalendar<TaskModel>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        calendarFormat: calendarFormat,
        onDaySelected: onDaySelected,
        onFormatChanged: onFormatChanged,
        onPageChanged: onPageChanged,
        eventLoader: _getTasksForDay,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
          ),
          markerDecoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          outsideDaysVisible: false,
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonDecoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          formatButtonTextStyle: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
