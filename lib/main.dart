import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              centerTitle: true,
              titleTextStyle: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 42, 42, 42),
              ),
              backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
