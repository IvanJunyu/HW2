import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '';
  String result = '';
  String operator = '';
  double? firstNumber;
  double? secondNumber;
  String equation = '';

  void onNumberPress(String number) {
    setState(() {
      if (result.isNotEmpty && firstNumber == null) {
        result = '';
        equation = '';
      }
      input += number;
      if (operator.isEmpty) {
        equation = input;
      } else {
        equation = '$firstNumber $operator $input';
      }
    });

    if (operator.isNotEmpty && firstNumber != null) {
      secondNumber = double.tryParse(input);
      calculateResult();
    }
  }

  void onOperatorPress(String op) {
    if (input.isNotEmpty && firstNumber == null) {
      firstNumber = double.tryParse(input);
      operator = op;
      setState(() {
        input = '';
        equation = '$firstNumber $operator';
      });
    }
  }

  void calculateResult() {
    if (secondNumber != null && firstNumber != null && operator.isNotEmpty) {
      double? calcResult;
      switch (operator) {
        case '+':
          calcResult = firstNumber! + secondNumber!;
          result = calcResult.toString();
          break;
        case '-':
          calcResult = firstNumber! - secondNumber!;
          result = calcResult.toString();
          break;
        case '*':
          calcResult = firstNumber! * secondNumber!;
          result = calcResult.toString();
          break;
        case '/':
          if (secondNumber != 0) {
            calcResult = firstNumber! / secondNumber!;
            result = calcResult.toString();
          } else {
            result = 'Error';
          }
          break;
      }

      setState(() {
        input = '';
        firstNumber = null;
        operator = '';
      });
    }
  }

  Widget buildButton(String text, {Function()? onPressed}) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              equation,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('+', onPressed: () => onOperatorPress('+')),
                    buildButton('-', onPressed: () => onOperatorPress('-')),
                    buildButton('*', onPressed: () => onOperatorPress('*')),
                    buildButton('/', onPressed: () => onOperatorPress('/')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('1', onPressed: () => onNumberPress('1')),
                    buildButton('2', onPressed: () => onNumberPress('2')),
                    buildButton('3', onPressed: () => onNumberPress('3')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('4', onPressed: () => onNumberPress('4')),
                    buildButton('5', onPressed: () => onNumberPress('5')),
                    buildButton('6', onPressed: () => onNumberPress('6')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('7', onPressed: () => onNumberPress('7')),
                    buildButton('8', onPressed: () => onNumberPress('8')),
                    buildButton('9', onPressed: () => onNumberPress('9')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('0', onPressed: () => onNumberPress('0')),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
