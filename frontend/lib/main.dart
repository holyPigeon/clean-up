import 'package:flutter/material.dart';
import 'package:kyonggi_project/screens/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(135, 206, 235, 1),
        textTheme: Typography.whiteCupertino,
      ),
      home: const RoutePage(),
    );
  }
}
