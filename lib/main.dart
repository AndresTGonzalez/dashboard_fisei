import 'package:dashboard_fisei/firebase_options.dart';
import 'package:dashboard_fisei/layout.dart';
import 'package:dashboard_fisei/pages/login_page.dart';
import 'package:dashboard_fisei/providers/auth_service.dart';
import 'package:dashboard_fisei/utils/custom_scroll_behivor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: '/login',
      routes: {
        '/dashboard': (context) {
          if (FirebaseAuth.instance.currentUser != null) {
            AuthProvider.testToken();
            return const Layout();
          }
          return const LoginPage();
        },
        '/login': (context) => const LoginPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
