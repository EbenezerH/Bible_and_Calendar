import 'package:flutter/material.dart';

class FormatString extends StatefulWidget {
  const FormatString({Key? key}) : super(key: key);

  @override
  State<FormatString> createState() => _FormatStringState();
}

class _FormatStringState extends State<FormatString> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text.rich(TextSpan(children: [])),
    );
  }
}
