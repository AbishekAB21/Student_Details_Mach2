
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_practice/db/functions/db_functions.dart';
import 'package:sqflite_practice/db/models/data_model.dart';

//final _SearchController = TextEditingController();
final _UpdatedNameController = TextEditingController();
final _UpdatedAgeController = TextEditingController();
final _UpdatedClassController = TextEditingController();
final _UpdatedAddressController = TextEditingController();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
List<StudentModel> studentlist = [];

void _searchstudent(String query) async{
  final results = await searchStudents(query);
  setState(() {
    studentlist = results;
  });
}

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        title: Text("Student Search"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: 
        
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  //controller: _SearchController,
                  onChanged: (query) {
                    _searchstudent(query);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                    labelText: "Enter Student Name",
                  ),
                ),
              ),
              Expanded(child: ListView.builder(
                itemCount: studentlist.length,
                itemBuilder: (context, index) {
                  final student = studentlist[index];
                  return GestureDetector(
                    onTap: () {

//--------------------------DISPLAYING BOTTOMSHEET-------------------------------

                      showModalBottomSheet(context: context, builder: (ctx1){
                        return Container(
                             child: Column(
                              children: [
                                CloseButton(color: Colors.red,),
                                Text("Name: "+student.name,
                                style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              
                            ),
                            ),

                            SizedBox(height: 15),
    
                            Text("Age: "+ student.age,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              
                            ),
                            ),
    
                            SizedBox(height: 15),
    
                            Text("Class: "+ student.cls,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              
                            ),
                            ),
    
                            SizedBox(height: 15),
    
                            Text("Address: " + student.address,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              
                            ),
                            ),

                            SizedBox(height: 15,),

//--------------------------DISPLAYING BOTTOMSHEET OVER-------------------------------                            

//--------------------------EDIT OPERATIONS-------------------------------

                            TextButton.icon(
                              onPressed: (){
                                Navigator.of(ctx1).pop();

                                showModalBottomSheet(context: context, builder: (ctx2){

                                 return Container(
                               child: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: ListView(
                                  children: [
                                    Center(child: Title(color: Colors.black, child: Text("Edit Student details",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                    ))),
                                    SizedBox(height: 30,),
                                    TextFormField(
                                      controller: _UpdatedNameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Name",
                                      ),
                                    ),
                                    
                                    SizedBox(height: 10,),

                                    TextFormField(
                                      controller: _UpdatedAgeController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Age",
                                      ),
                                    ),
                                    
                                     SizedBox(height: 10,),

                                    TextFormField(
                                      controller: _UpdatedClassController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Class",
                                      ),
                                    ),
                                    
                                     SizedBox(height: 10,),

                                    TextFormField(
                                      controller: _UpdatedAddressController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Address",
                                      ),
                                    ),
                                    
                                    SizedBox(height: 10,),

                                    ElevatedButton.icon(
                                      onPressed: () async{
                                        await updateStudent(student.id, 
                                         _UpdatedNameController.text, 
                                         _UpdatedAgeController.text, 
                                         _UpdatedClassController.text, 
                                         _UpdatedAddressController.text
                                         );

                                         _UpdatedNameController.clear();
                                         _UpdatedAgeController.clear();
                                         _UpdatedClassController.clear();
                                         _UpdatedAddressController.clear();

                                         ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                behavior: SnackBarBehavior.floating,
                                                backgroundColor: Colors.green[900],
                                                duration: Duration(seconds: 10),
                                                showCloseIcon: true,
                                                closeIconColor: Colors.white,
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.edit_rounded ,color: Colors.white,),
                                                    Text(" Successfully Edited",
                                                    style: TextStyle(color: Colors.white),
                                              ),
                                                  ],
                                                )
                                                ));
                                         
                                      }, 

                                      icon: Icon(Icons.update), 

                                      label: Text("Update Details")
                                      
                                      ),
                                      
                                  ],
                                 ),
                               ),
                            );
                            

                                } );
                              }, 
                              icon: Icon(Icons.edit), 
                              label: Text("Edit Student details")
                              )

                              ],
                             ),
                        );
                      });
                    },

//--------------------------EDIT OPERATIONS OVER-------------------------------

                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.black38,
                      color: Colors.grey[300],
                        child: ListTile(
                        title: Text(student.name),
                        leading: CircleAvatar(backgroundImage: FileImage(File(student.img)),),

//--------------------------DELETION OPERATIONS-------------------------------

                        trailing: IconButton(
                          onPressed: (){
                               showDialog(
                                  context: context, 
                                  builder: (ctx){
                                   return AlertDialog(
                                  title: Text("Delete Student record"),
                                  content: Text("Proceed with deletion ?"),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        
                                       if(student.id != null)
                                         {
                                              deleteStudent(student.id!);

                                              ScaffoldMessenger.of(ctx).showSnackBar(
                                              SnackBar(
                                                behavior: SnackBarBehavior.floating,
                                                duration: Duration(seconds: 5),
                                                showCloseIcon: true,
                                                closeIconColor: Colors.white,
                                                backgroundColor: Colors.red[600],
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.delete_forever ,color: Colors.white,),
                                                    Text(" Successfully deleted",
                                                    style: TextStyle(color: Colors.white),
                                              ),
                                                  ],
                                                )
                                                ));
                                         }
                                           else{
                                                 print("Student id is null. Unable to delete.");
                                               }
                                        Navigator.of(ctx).pop();     
                                 
                                      }, 
                                      child: Text("Yes")
                                      ),
                                    
                                    TextButton(
                                      onPressed: (){
                                        Navigator.of(ctx).pop();
                                      }, 
                                      child: Text("No"))
                                  ],
                                );
                                  });
                          }, 
                          icon: Icon(Icons.delete, color: Colors.red[900],)),

//--------------------------DELETION OPERATIONS OVER-------------------------------

                      ),
                    ),
                  );
                },))
            ],
          ),
          
        )
        
        
        )

      
    );

  }

}