import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_assignment/screens/newspage.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
    child: DevicePreview(
        builder: (context) => const MainApp(), // Wrap your app
      ),
  ),);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home:NewsPage(),
    );
  }
}
