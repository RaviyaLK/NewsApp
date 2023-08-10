import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../colors.dart';


class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.grey,
        backgroundColor: hexStringToColor("#1858d2"),
        centerTitle: true,
        title: Text('News Feed'),
      ),

    );
  }
}