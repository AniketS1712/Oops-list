import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/task_providers.dart';
import 'package:to_do_app/providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final taskProvider = Provider.of<TaskProviders>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final tasks = taskProvider.tasks;

    final totalTasks = tasks.length;
    final completedTasks = tasks.where((t) => t.isCompleted).length;
    final pendingTasks = totalTasks - completedTasks;
    final overdueTasks = tasks.where((t) {
      return t.date.isBefore(DateTime.now()) && !t.isCompleted;
    }).length;

    final completionRate = totalTasks == 0
        ? 0.0
        : (completedTasks / totalTasks * 100);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.redAccent.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text('🤷', style: TextStyle(fontSize: 50)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Professional Procrastinator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Master of Postponement',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${completionRate.toStringAsFixed(1)}% Completion Rate',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Sarcastic Achievement
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.military_tech,
                      color: Colors.orange,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getAchievement(completionRate),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getAchievementMessage(completionRate),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Statistics
            Text(
              'Your "Productivity" Stats',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.list_alt,
                    label: 'Total Tasks',
                    value: totalTasks.toString(),
                    color: Colors.blue,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.check_circle,
                    label: 'Completed',
                    value: completedTasks.toString(),
                    color: Colors.green,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.pending,
                    label: 'Pending',
                    value: pendingTasks.toString(),
                    color: Colors.orange,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.warning,
                    label: 'Overdue',
                    value: overdueTasks.toString(),
                    color: Colors.red,
                    isDark: isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Settings Section
            Text(
              'Settings',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Container(
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
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Because darkness matches your mood'),
                    secondary: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: Colors.redAccent,
                    ),
                    value: themeProvider.isDarkMode,
                    onChanged: (_) => themeProvider.toggleTheme(),
                    activeColor: Colors.redAccent,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    title: const Text('Clear All Tasks'),
                    subtitle: const Text('Start fresh (aka give up)'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Clear All Tasks?'),
                          content: const Text(
                            'This will delete ALL your tasks. Ready to admit defeat?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No, wait!'),
                            ),
                            TextButton(
                              onPressed: () {
                                for (var task in tasks.toList()) {
                                  taskProvider.deleteTask(task);
                                }
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'All tasks deleted. Fresh start! 🗑️',
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('Yes, delete all'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Sarcastic Quote
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.redAccent.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.format_quote,
                    color: Colors.redAccent,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '"The best time to do a task was yesterday. The second best time is... well, maybe tomorrow?"',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '- Oops!List Philosophy',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _getAchievement(double rate) {
    if (rate >= 80) return 'Overachiever! 🎉';
    if (rate >= 60) return 'Not Bad! 👍';
    if (rate >= 40) return 'Trying... Sort Of 🤷';
    if (rate >= 20) return 'Room for Improvement 😅';
    return 'Professional Procrastinator 🏆';
  }

  String _getAchievementMessage(double rate) {
    if (rate >= 80) return 'Who are you and what did you do with the real you?';
    if (rate >= 60)
      return 'Keep this up and people might think you\'re productive!';
    if (rate >= 40) return 'Baby steps count... I guess?';
    if (rate >= 20) return 'At least you showed up!';
    return 'Mastered the art of doing nothing!';
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  const _StatCard({
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
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
