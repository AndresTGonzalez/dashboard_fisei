import 'package:dashboard_fisei/layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horarios FISEI - Admin',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Layout(),
      debugShowCheckedModeBanner: false,
    );
  }
}
