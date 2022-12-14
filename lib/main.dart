import 'package:flutter/material.dart';
import 'View/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  // this is the main class for first time run the app
  // build one time in the app running
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      // use material app or GetAaterilaApp
      home: LogInView(),
    );
  }
}
