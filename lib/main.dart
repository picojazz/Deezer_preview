import 'package:flutter/material.dart';
import 'package:picojazz_deezer_preview/home.dart';
import 'package:picojazz_deezer_preview/player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
