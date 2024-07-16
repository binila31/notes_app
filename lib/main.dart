import 'package:flutter/material.dart';

import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/service/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Preferences prefs = Preferences();
  bool isDarkTheme = await prefs.getTheme();

  runApp(MyApp(isDarkTheme: isDarkTheme));
}

class MyApp extends StatefulWidget {
  final bool isDarkTheme;

  MyApp({required this.isDarkTheme});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkTheme;
  Preferences _preferences = Preferences();

  @override
  void initState() {
    super.initState();
    _isDarkTheme = widget.isDarkTheme;
  }

  void _toggleTheme() async {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
    await _preferences.setTheme(_isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData.light().copyWith(
        cardColor: Colors.limeAccent,
        textTheme: TextTheme(

          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.grey),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        cardColor: Colors.grey[800],
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.grey[300]),
        ),
      ),
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(onToggleTheme: _toggleTheme),
    );
  }
//  return MaterialApp(
//   title: 'Notes App',
//    theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
//  home: HomeScreen(onToggleTheme: _toggleTheme),
//  );
// }
//}
}