import 'package:calculator/calculator.dart';
import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {
  final void Function(String) onPressed;
  const NumPad({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 2,
          width: MediaQuery.of(context).size.width,
          child: Container(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        for (final row in keys)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final value in row)
                Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: NumButton(
                    value: value,
                    onPressed: onPressed,
                  ),
                ),
            ],
          )
      ],
    );
  }
}

class NumButton extends StatelessWidget {
  final String value;
  final void Function(String) onPressed;
  const NumButton({super.key, required this.value, required this.onPressed});

  bool get isNum => double.tryParse(value) != null;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed(value);
      },
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(CircleBorder()),
        backgroundColor: WidgetStatePropertyAll(
            isNum ? Colors.grey.shade700 : Colors.grey.shade400),
        foregroundColor:
            WidgetStatePropertyAll(isNum ? Colors.white : Colors.green),
        minimumSize: WidgetStatePropertyAll(
            Size.fromRadius(MediaQuery.of(context).size.width / 10)),
      ),
      child: Text(
        value,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
