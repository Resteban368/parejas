import 'package:flutter/material.dart';
import 'package:parejas/screens/flipcardgame.dart';
import 'package:parejas/screens/splash_scrren.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
    debugShowCheckedModeBanner: false,
     initialRoute: '/',
      routes: {
        '/game': (context) => const FlipCardGane(),
        '/': (context) => const SplashScreen(),
      },

         
    );
  }
}

