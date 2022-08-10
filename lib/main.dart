import 'package:flutter/material.dart';
import 'package:image_search_app/screens/main_screen.dart';
import 'package:image_search_app/screens/screens/image_screen/image_search_view_model.dart';
import 'package:provider/provider.dart';
import 'color_schemes.g.dart';

void main() {
  runApp(const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: ChangeNotifierProvider(
      create: (context) => ImageSearchViewModel(),
      child: const MainScreen(),
    ));
  }
}
