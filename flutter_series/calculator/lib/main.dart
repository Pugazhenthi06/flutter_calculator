import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String inputvalue = "";
  String calcvalue = "";
  String operator = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Calculator"),
          backgroundColor: Colors.yellow,
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Text(
                    inputvalue,
                    style: const TextStyle(color: Colors.white, fontSize: 48),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                ..._buildButtonRows(context),
                const SizedBox(height: 15),
                _buildClearButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildButtonRows(BuildContext context) {
    final buttonRows = [
      ["7", "8", "9", "/"],
      ["4", "5", "6", "x"],
      ["1", "2", "3", "-"],
      ["0", ".", "=", "+"],
    ];

    return buttonRows.map((row) {
      return Row(
        children: row.map((text) {
          final isOperator = "+-x/=".contains(text);
          final color = isOperator ? Colors.orange : Colors.grey.shade800;
          return _buildCalcButton(text, color);
        }).toList(),
      );
    }).toList();
  }

  Widget _buildCalcButton(String text, Color bgColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () => _handleButtonPress(text),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            onPressed: () {
              setState(() {
                inputvalue = "";
                calcvalue = "";
                operator = "";
              });
            },
            child: const Text(
              "Clear",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _handleButtonPress(String text) {
    setState(() {
      if ("+-x/".contains(text)) {
        operator = text;
        calcvalue = inputvalue;
        inputvalue = "";
      } else if (text == "=") {
        try {
          final a = double.parse(calcvalue);
          final b = double.parse(inputvalue);

          switch (operator) {
            case "+":
              inputvalue = (a + b).toString();
              break;
            case "-":
              inputvalue = (a - b).toString();
              break;
            case "x":
              inputvalue = (a * b).toString();
              break;
            case "/":
              if (b == 0) {
                _showSnack("Cannot divide by zero!");
              } else {
                inputvalue = (a / b).toString();
              }
              break;
          }
        } catch (_) {
          _showSnack("Invalid input");
        }
      } else {
        inputvalue += text;
      }
    });
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
