import 'package:flutter/material.dart';
import 'package:news/pages/pages.dart';
import 'package:news/services/news_service.dart';
import 'package:news/theme/dark.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsService(),
        ),
      ],
      child: MaterialApp(
        theme: temita,
        debugShowCheckedModeBanner: false,
        home: const TabPage(),
      ),
    );
  }
}
