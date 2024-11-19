import 'package:calculator/num_pad.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:toastification/toastification.dart';

const keys = [
  [
    '7',
    '8',
    '9',
    '+',
  ],
  [
    '4',
    '5',
    '6',
    '-',
  ],
  [
    '1',
    '2',
    '3',
    '*',
  ],
  [
    '0',
    'C',
    '=',
    '/',
  ],
];

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = "";
  String _result = "";

  dynamic _calculate() {
    try {
      final double res = Parser()
          .parse(_expression)
          .evaluate(EvaluationType.REAL, ContextModel());
      _result = res.toStringAsFixed(5);
    } catch (e) {
      return Error();
    }
  }

  void _showToast() {
    toastification.show(
      context: context,
      title: Text("Invalid expression"),
      autoCloseDuration: Duration(seconds: 2),
      style: ToastificationStyle.simple,
      type: ToastificationType.error,
      closeOnClick: true,
      pauseOnHover: false,
      alignment: Alignment.topLeft,
    );
  }

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
        return;
      }
      if (value == "=") {
        final err = _calculate();
        if (err != null) {
          _showToast();
        }
        return;
      }
      // if we press another key after a result is shown,
      // start expression from that value
      if (_result.isNotEmpty) {
        _expression = _result;
        _result = '';
      }
      _expression += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ResultBox(
            expression: _expression,
            result: _result,
          ),
        ),
        NumPad(
          onPressed: _onPressed,
        ),
      ],
    );
  }
}

class ResultBox extends StatelessWidget {
  final String expression;
  final String result;
  const ResultBox({super.key, required this.expression, required this.result});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              expression,
              softWrap: true,
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
          ),
          Text(
            result,
            style: TextStyle(color: Colors.grey, fontSize: 23),
          ),
        ],
      ),
    );
  }
}