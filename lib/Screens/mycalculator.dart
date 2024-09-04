import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/provider/calculator_provider.dart';
import 'package:flutter_calculator/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => MyCalculatorState();
}

class MyCalculatorState extends State<MyCalculator> {
  final numberBgColor = Colors.grey[800]!;
  final symbolBgColor = Colors.amber[800]!;
  Map<String, bool> buttonStates = {};

  void handleTap(String text) {
    setState(() {
      buttonStates[text] = true;
    });
    Provider.of<CalculatorProvider>(context, listen: false).setValue(text);
    Timer(const Duration(milliseconds: 150), () {
      setState(() {
        buttonStates[text] = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(builder: (context, provider, _) {
      // Determine the text color based on the current theme mode
      Color resultTextColor = Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;

      return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Calculator'),
          actions: [
            IconButton(
              icon: Icon(
                Provider.of<ThemeProvider>(context).isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                // Toggle the theme when the icon is clicked
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(
                    !Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Display result
                Align(
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      provider.displayText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 60,
                        color: resultTextColor, // Set dynamic text color
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // First row of buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    numberSymbolButton(Colors.grey[400]!, "AC", Colors.black87),
                    numberSymbolButton(
                        Colors.grey[400]!, "+/-", Colors.black87),
                    numberSymbolButton(Colors.grey[400]!, "%", Colors.black87),
                    numberSymbolButton(symbolBgColor, "/", Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                // Second row of buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    numberSymbolButton(numberBgColor, "7", Colors.white),
                    numberSymbolButton(numberBgColor, "8", Colors.white),
                    numberSymbolButton(numberBgColor, "9", Colors.white),
                    numberSymbolButton(symbolBgColor, "x", Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    numberSymbolButton(numberBgColor, "4", Colors.white),
                    numberSymbolButton(numberBgColor, "5", Colors.white),
                    numberSymbolButton(numberBgColor, "6", Colors.white),
                    numberSymbolButton(symbolBgColor, "-", Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    numberSymbolButton(numberBgColor, "1", Colors.white),
                    numberSymbolButton(numberBgColor, "2", Colors.white),
                    numberSymbolButton(numberBgColor, "3", Colors.white),
                    numberSymbolButton(symbolBgColor, "+", Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                // Row for 0
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: numberBgColor,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.fromLTRB(35, 12, 128, 12),
                      ),
                      onPressed: () => handleTap("0"),
                      child: const Text(
                        "0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    numberSymbolButton(numberBgColor, ".", Colors.white),
                    numberSymbolButton(numberBgColor, "=", Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Widget numberSymbolButton(Color bgColor, String text, Color textColor) {
  //   bool isChange = buttonStates[text] ?? false;
  //   return GestureDetector(
  //     onTap: () => handleTap(text),
  //     child: Container(
  //       height: 80,
  //       width: 80,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: isChange ? Colors.white38 : bgColor,
  //       ),
  //       child: Center(
  //         child: Text(
  //           text,
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 35,
  //             color: textColor,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget numberSymbolButton(Color bgColor, String text, Color textColor) {
  bool isPressed = buttonStates[text] ?? false;
  
  // Get the current theme mode (light or dark)
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  // Set the text color to black when pressed, otherwise use the default color
  Color currentTextColor = isPressed ? Colors.black : textColor;

  return GestureDetector(
    onTap: () => handleTap(text),
    child: Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isPressed ? Colors.white38 : bgColor, // Use pressed background
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: currentTextColor,
          ),
        ),
      ),
    ),
  );
}
}
