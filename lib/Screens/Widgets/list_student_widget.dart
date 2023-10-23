import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_practice/Screens/searchScreen.dart';
import 'package:sqflite_practice/db/functions/db_functions.dart';
import 'package:sqflite_practice/db/models/data_model.dart';

class ListStudentWidget extends StatelessWidget {
   ListStudentWidget({super.key});

  final _UpdatedNameController = TextEditingController();
  final _UpdatedAgeController = TextEditingController();
  final _UpdatedClassController = TextEditingController();
  final _UpdatedAddressController = TextEditingController();

  //String imagePath;

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
     
     appBar: AppBar(
      title: Text("Student List"),
      centerTitle: true,
      actions: [
       IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchScreen()));
       }, 
       icon: Icon(Icons.search)) 
      ],
     ),

      body:
      ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: 
            (BuildContext ctx , List<StudentModel> studentlist,Widget? child){
          return ListView.separated(
          itemBuilder: (ctx,index){
            final data = studentlist[index];
            return Card(
              elevation: 4,
              shadowColor: Colors.black38,
              color: Colors.grey[300],
              child: ListTile(
                onTap: (){
                  
                 showModalBottomSheet(context: ctx, builder: (ctx1){
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Container(
                          child: Column(
                            children: [
                              CloseButton(color: Colors.red,),
                              Text("Name: "+data.name,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                
                              ),
                              ),
                
                              SizedBox(height: 15),
                
                              Text("Age: "+ data.age,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                
                              ),
                              ),
                
                              SizedBox(height: 15),
                
                              Text("Class: "+ data.cls,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                
                              ),
                              ),
                
                              SizedBox(height: 15),
                
                              Text("Address: " + data.address,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                
                              ),
                              ),
            
                              
                            ],
                          ),
                          
                        
                      ),
                    );
                 });
                
                },
                title: Text(data.name),
                //subtitle: Text(data.age),
                leading:   

                // imagePath = data.img; 
                // File imageFile = File(imagePath);
                //  if (imageFile.existsSync()) {
                //   Uint8List imageBytes = imageFile.readAsBytesSync();
                //    MemoryImage memoryImage = MemoryImage(imageBytes);
                //      CircleAvatar(
                //          backgroundImage: memoryImage,
                //          radius: 20,
                //         );
                //        } 
                
                CircleAvatar(backgroundImage: FileImage(File(data.img)),
                radius: 20,
                ),
                      
                trailing:
                       Row(
                        mainAxisSize: MainAxisSize.min,
                         children: [
                           IconButton(
                              onPressed: (){
                                
                                showDialog(
                                  context: ctx, 
                                  builder: (ctx){
                                   return AlertDialog(
                                  title: Text("Delete Student record"),
                                  content: Text("Proceed with deletion ?"),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        
                                       if(data.id != null)
                                         {
                                              deleteStudent(data.id!);

                                              ScaffoldMessenger.of(ctx).showSnackBar(
                                              SnackBar(
                                                behavior: SnackBarBehavior.floating,
                                                backgroundColor: Colors.red[600],
                                                duration: Duration(seconds: 5),
                                                showCloseIcon: true,
                                                closeIconColor: Colors.white,
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
                                
                                 //deleteStudent(index);
                                
                              },
                              icon: Icon(Icons.delete , color: Colors.red[700],)
                            ),
                          IconButton(
                          onPressed: ()
                      {
                           //Editing Student data

                          showDialog(context: context, builder: (ctx){
                            return AlertDialog(
                              title: Text("Edit Student Details"),
                              content: Text("Proceed to edit details ?"),
                              actions: [
                                TextButton(onPressed: () {
                                
                                 Navigator.of(ctx).pop();

                       showModalBottomSheet(context: context, builder: (ctx)
                           
                          {
                            
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
                                        await updateStudent(data.id, 
                                         _UpdatedNameController.text, 
                                         _UpdatedAgeController.text, 
                                         _UpdatedClassController.text, 
                                         _UpdatedAddressController.text
                                         );

                                         _UpdatedNameController.clear();
                                         _UpdatedAgeController.clear();
                                         _UpdatedClassController.clear();
                                         _UpdatedAddressController.clear();

                                         ScaffoldMessenger.of(ctx).showSnackBar(
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
                            
                           });

                           

                                }, 
                                child: Text("Yes")
                                
                                ),

                                TextButton(
                                  onPressed: (){
                                    Navigator.of(ctx).pop();
                                  }, 
                                  child: Text("No")
                                  )
                              ],
                              
                            );
                          });


                          }, 
                          icon: Icon(Icons.edit))
                         ],
                       ),
                        
                        
                  
              ),
            );
          },
          separatorBuilder: (ctx,index){
            return const SizedBox(height: 5,); //Divider();
          },
      
          itemCount: studentlist.length);
        },
        
      ),
    );
  }
}