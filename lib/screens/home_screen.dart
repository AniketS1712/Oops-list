import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/providers/task_providers.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/screens/calendar_screen.dart';
import 'package:to_do_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedFilter = 'All';

  String getRandomGreeting() {
    final greetings = [
      "Still pretending to be productive?",
      "Back again? Didn't finish yesterday's list?",
      "Let's make more tasks you won't do!",
      "Motivation level: buffering...",
      "Oh look, someone's *trying*!",
      "Tasks? Or just wishful thinking?",
      "Another day, another delay!",
      "Wow, you showed up. Impressive!",
      "Procrastination station is open!",
      "Ready to disappoint yourself?",
    ];
    greetings.shuffle(Random());
    return greetings.first;
  }

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final completedCount = allTasks.where((t) => t.isCompleted).length;
    final totalCount = allTasks.length;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
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
            color: theme.colorScheme.onSurface,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header Section with Stats ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent.withOpacity(0.1),
                  theme.colorScheme.surface,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getRandomGreeting(),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Your daily dose of disappointment.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 16),
                // Progress Card
                Container(
                  padding: const EdgeInsets.all(16),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$completedCount / $totalCount",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: totalCount == 0
                              ? 0
                              : completedCount / totalCount,
                          minHeight: 8,
                          backgroundColor: isDark
                              ? Colors.grey[700]
                              : Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- Filter Chips ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Today', 'Upcoming', 'Overdue', 'Completed']
                    .map(
                      (filter) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                          selectedColor: Colors.redAccent.withOpacity(0.2),
                          checkmarkColor: Colors.redAccent,
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter
                                ? Colors.redAccent
                                : theme.colorScheme.onSurface,
                            fontWeight: _selectedFilter == filter
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

          // --- Task List Section ---
          Expanded(
            child: filteredTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 80,
                          color: theme.colorScheme.onBackground.withOpacity(
                            0.3,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _selectedFilter == 'All'
                              ? "🤷‍♂️ Nothing to see here!"
                              : "No ${_selectedFilter.toLowerCase()} tasks",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Add a task before I start judging you.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onBackground.withOpacity(
                              0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      final isOverdue =
                          task.date.isBefore(DateTime.now()) &&
                          !task.isCompleted;

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
                        onDismissed: (_) => taskProvider.deleteTask(task),
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => TaskDetailScreen(task: task),
                              //   ),
                              // );
                            },
                            leading: Checkbox(
                              activeColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              value: task.isCompleted,
                              onChanged: (_) =>
                                  taskProvider.toggleComplete(task),
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
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 12,
                                      color: isOverdue
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      DateFormat(
                                        'MMM dd, yyyy',
                                      ).format(task.date),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isOverdue
                                            ? Colors.red
                                            : Colors.grey,
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
                                ? const Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                    size: 20,
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // --- Floating OOPS! Button ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        elevation: 4,
        onPressed: () => Navigator.pushNamed(context, '/add_task'),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),

      // --- Bottom Bar ---
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: isDark ? Colors.grey[850] : Colors.redAccent,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CalendarScreen()),
                  );
                },
              ),
              const SizedBox(width: 48), // space for FAB
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Colors.white,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
