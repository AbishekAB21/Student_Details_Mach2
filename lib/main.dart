

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_practice/Screens/screen_home.dart';
import 'package:sqflite_practice/db/functions/db_functions.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await openDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Student Details",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenHome(),
    );
  }
}