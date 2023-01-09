import 'package:flutter/material.dart';

class DocumentButton extends StatelessWidget {
  final String? title;
  const DocumentButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        border: Border.all(style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(title!),
      ),
    );
  }
}