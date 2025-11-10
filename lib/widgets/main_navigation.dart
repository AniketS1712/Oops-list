import 'package:flutter/material.dart';
import 'package:oops_list/providers/theme_provider.dart';
import 'package:oops_list/screens/add_task_screen.dart';
import 'package:oops_list/screens/home_screen.dart';
import 'package:oops_list/screens/calendar_screen.dart';
import 'package:oops_list/screens/profile_screen.dart';
import 'package:oops_list/widgets/bottom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  final ThemeProvider themeProvider;

  const MainNavigation({super.key, required this.themeProvider});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavBar(
        themeProvider: widget.themeProvider,
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
        onFabPressed: _onFabPressed,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: Colors.redAccent,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
