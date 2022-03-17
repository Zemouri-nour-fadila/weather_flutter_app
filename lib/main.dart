import 'package:flutter/material.dart';
import 'package:weather_flutter_app/ui/DetailPage.dart';
import 'package:weather_flutter_app/ui/HomePage.dart';
import 'package:weather_flutter_app/ui/SearchPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/Location': (_) => const DetailPage(),
        '/Search': (_) => const SearchPage()
      },
    );
  }
}
