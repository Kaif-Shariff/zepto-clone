import 'package:clone/firebase_options.dart';
import 'package:clone/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zepto Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const HomePage(),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
