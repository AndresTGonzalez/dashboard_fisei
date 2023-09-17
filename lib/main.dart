import 'package:dashboard_fisei/layout.dart';
import 'package:dashboard_fisei/utils/custom_scroll_behivor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Horarios FISEI - Admin',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) => const Layout(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
