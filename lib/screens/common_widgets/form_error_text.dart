import 'package:flutter/material.dart';

class FormErrorText extends StatelessWidget {
  final String? text;

  const FormErrorText({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text!,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

