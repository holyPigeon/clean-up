import 'package:flutter/material.dart';

basicButton({
  required String buttonText,
  required Function() onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      buttonText,
      style: const TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
    ),
  );
}