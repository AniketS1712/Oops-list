import 'package:flutter/material.dart';
import 'package:oops_list/providers/theme_provider.dart';

class BottomNavBar extends StatelessWidget {
  final ThemeProvider themeProvider;
  final int currentIndex;
  final Function(int) onTabSelected;
  final VoidCallback onFabPressed;

  const BottomNavBar({
    super.key,
    required this.themeProvider,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onFabPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(), // makes the curve for FAB
      notchMargin: 8,
      color: isDark ? Colors.grey[850] : Colors.redAccent,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: currentIndex == 0 ? Colors.white : Colors.white70,
              ),
              onPressed: () => onTabSelected(0),
            ),
            IconButton(
              icon: Icon(
                Icons.calendar_month,
                color: currentIndex == 1 ? Colors.white : Colors.white70,
              ),
              onPressed: () => onTabSelected(1),
            ),
            const SizedBox(width: 48), // reserved space for FAB
            IconButton(
              icon: Icon(
                Icons.person,
                color: currentIndex == 2 ? Colors.white : Colors.white70,
              ),
              onPressed: () => onTabSelected(2),
            ),
            IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white,
              ),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
