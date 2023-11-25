import 'package:flutter/material.dart';
import 'package:internship_project/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.black,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData.dark(),
      darkTheme: darkTheme,
      home: const SplashScreen(),
    );
  }
}
