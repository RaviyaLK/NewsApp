import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_assignment/screens/newspage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
    child:  MainApp(),
  ),);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:ThemeData(
  
    primaryColor: Colors.lightBlue[800],

    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 20, ),
      bodyMedium: TextStyle(fontSize: 13, color: Colors.blueGrey),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.black45, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color:Colors.black),
      headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color:Colors.black),
      displaySmall:  TextStyle(fontSize: 17, color:Colors.white),
    ),
  ), 
      debugShowCheckedModeBanner: false,
      home:const NewsPage(),
    );
  }
}
