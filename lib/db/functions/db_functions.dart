import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_practice/db/models/data_model.dart';



ValueNotifier<List<StudentModel>>studentListNotifier = ValueNotifier([]);

late Database _db;

//Opening and Creating database

Future <void> openDB() async{
_db = await openDatabase('Student.db', version: 1 , onCreate: (db, version) async{
  await db.execute(
    'CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, class TEXT, address TEXT, image TEXT)'
    );
 },);
}

//Adding student details into database

Future <void> addStudent(StudentModel value) async
{
  await _db.rawInsert('INSERT INTO student(name,age,class,address,image) VALUES(?,?,?,?,?)',[value.name , value.age , value.cls , value.address , value.img]);
  getAllStudents();
}

//Retriving all the student details we stored in the database

Future<void> getAllStudents() async{
  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);
  studentListNotifier.value.clear();

 _values.forEach((map){
  final student = StudentModel.fromMap(map);
  studentListNotifier.value.add(student);
  studentListNotifier.notifyListeners(); 
 });
 
 //Deleteing student records from databse
  
}

Future <void> deleteStudent(int id) async{

  await _db.rawDelete('DELETE FROM student WHERE  id = ?', [id]);

  getAllStudents();
  
}

 //Search bar operations

Future<List<StudentModel>>
searchStudents(String query) async{
  final db = await _db.database;
  final List<Map<String,dynamic>>
  maps = await db.rawQuery("SELECT* FROM student WHERE name LIKE '%$query%'");
  return List.generate(maps.length, (i){
    return StudentModel.fromMap(maps[i]);
  });
}

 //Editing Student details

Future<void> updateStudent(int? id, String name, String age, String cls, String address) async {
	await _db.rawUpdate('UPDATE student SET name = ?, age = ?, class = ?, address = ? WHERE id = ?',[name, age, cls, address, id]);
	getAllStudents();
}



