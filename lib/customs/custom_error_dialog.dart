import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final text;

  const CustomError({Key? key,required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("ok"))
      ],
    );
  }
}
