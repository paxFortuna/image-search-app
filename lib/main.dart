import 'package:flutter/material.dart';
import 'package:image_search_app/screens/main_screen.dart';
import 'package:image_search_app/screens/screens/image_screen/image_search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
                                                                                primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
