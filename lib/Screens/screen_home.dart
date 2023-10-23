import 'package:flutter/material.dart';
import 'package:sqflite_practice/Screens/Widgets/add_student_widget.dart';
import 'package:sqflite_practice/Screens/Widgets/list_student_widget.dart';
import 'package:sqflite_practice/db/functions/db_functions.dart';


class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      // drawer: Drawer(
      
      // ),
      appBar: AppBar(
        title: Text("Add Student Details"),
        centerTitle: true,
    
      ),
      body: SafeArea(
        child: Column(
          children: [
            AddStudentWidget(),
            //const Expanded(child: ListStudentWidget())
          ],
        )
        ),
    );
  }
}