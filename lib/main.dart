import 'package:flutter/material.dart';
import 'package:flutter_calculator/Screens/mycalculator.dart';
import 'package:flutter_calculator/provider/calculator_provider.dart';
import 'package:flutter_calculator/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Calculator',
            themeMode: themeProvider.themeMode, // Dynamically change the theme
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(), // Define light and dark themes
            home: const MyCalculator(),
          );
        },
      ),
    );
  }
}
