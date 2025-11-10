import 'dart:math';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final int completedCount;
  final int totalCount;

  const HeaderSection({
    super.key,
    required this.completedCount,
    required this.totalCount,
  });

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
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
                    Text("Progress",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
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
                    value: totalCount == 0 ? 0 : completedCount / totalCount,
                    minHeight: 8,
                    backgroundColor:
                        isDark ? Colors.grey[700] : Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
