import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:oops_list/models/task_model.dart';
import 'package:oops_list/providers/task_providers.dart';
import 'package:oops_list/providers/theme_provider.dart';
import 'package:oops_list/screens/splash_screen.dart';
import 'package:oops_list/widgets/main_navigation.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('taskBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProviders()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OOPS!LIST',
            navigatorKey: navigatorKey, // ✅ Added
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.redAccent,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.redAccent,
              brightness: Brightness.dark,
            ),
            home: SplashScreen(
              onSplashEnd: () {
                final themeProvider = Provider.of<ThemeProvider>(
                  navigatorKey.currentContext!,
                  listen: false,
                );

                navigatorKey.currentState!.pushReplacement(
                  MaterialPageRoute(
                    builder: (_) =>
                        MainNavigation(themeProvider: themeProvider),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
