import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_practice/Screens/Widgets/list_student_widget.dart';
import 'package:sqflite_practice/db/functions/db_functions.dart';
import 'package:sqflite_practice/db/models/data_model.dart';


class AddStudentWidget extends StatefulWidget {
   AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {

 String? imagePath;
 //XFile? imageFile;
 final picker=ImagePicker();

  final _nameController = TextEditingController();

  final _AgeController = TextEditingController();

  final _ClassController = TextEditingController();

  final _AddressController = TextEditingController();
  
 Future <void> takePhoto() async{
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(PickedFile != null)
    {
      setState(() {
        imagePath = PickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                  hintText: "Enter the student's name",
                ),
              ),
            
              SizedBox(height: 10,),
              
              TextFormField(
                controller: _AgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Age",
                  hintText: "Enter the student's age",
                ),
              ),
            
              SizedBox(height: 10,),
              
              TextFormField(
                controller: _ClassController, 
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Class",
                  hintText: "Enter the student's class",
                ),
              ),
            
              SizedBox(height: 10,),
              
              TextFormField(
                controller: _AddressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Address",
                  hintText: "Enter the student's address"
                ),
              ),
            
            
              SizedBox(height: 10,),

              Text("Upload Profile Picture", style: TextStyle(fontWeight: FontWeight.w600),),

              SizedBox(height: 10,),

              Stack(
                children: [
                  CircleAvatar( maxRadius: 50, 
                  backgroundImage: imagePath == null 
                  ?const NetworkImage('https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png') as ImageProvider
                  :FileImage(File(imagePath.toString())),
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: takePhoto, 
                      
                        //Get image
                        
                       
                      icon: Icon(Icons.add_a_photo),
                      ),
                       bottom: -10,
                       left: 60,
                      )
                ], 
              ),
            
              SizedBox(height: 10,),
            
              ElevatedButton.icon(
                onPressed: (){
                  AddStudentButtonClicked();

                }, 
                icon: Icon(Icons.add), 
                label: Text("Add Student")
                
                ),
            
              ElevatedButton.icon(onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ListStudentWidget()));
              },
              icon: Icon(Icons.list), 
              label: Text("Show List")
              
              )
            ],
          ),
        ),
      ),
    );
  }

    AddStudentButtonClicked() {
    //  final _name = _nameController.text.trim();
    //  final _age = _AgeController.text.trim();
    //  final _class = _ClassController.text.trim();
    //  final _address = _AddressController.text.trim();
     //final _imagedata = imagePath!;
     StudentAddButton();
    //  if(_name.isEmpty || _age.isEmpty)
    //  {
    //   return;
    //  }
    //  print('$_name $_age');

    //  final _student = StudentModel(name: _name, age: _age, cls: _class, address: _address, img: imagePath.toString());
    //  addStudent(_student);

    //  _nameController.clear();
    //  _AgeController.clear();
    //  _ClassController.clear();
    //  _AddressController.clear();
     
    
  }

  Future<void> StudentAddButton() async{
    List data = [
      _nameController.text.trim(),
      _AgeController.text.trim(),
      _ClassController.text.trim(),
      _AddressController.text.trim(),
      imagePath
    ];

    SnackBar mysnackbar = CheckError(data);
    ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
  }

  SnackBar CheckError(List data) {
  
  String field = ErrorCheck(data);

  if (field != "success") {
    SnackBar mysnackbar = SnackBar(
      content: Row(
        children: [const Icon(Icons.error, color: Colors.white,), Text(" $field is empty")],
      ),
      backgroundColor: Colors.red,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
    );
    return mysnackbar;
  } else {
    studentAdder(data);
    SnackBar mysnackbar = SnackBar(
      backgroundColor: Colors.green[700],
      showCloseIcon: true,
      closeIconColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 5),
        content: Row(
      children:const [Icon(Icons.done_all, color: Colors.white,), Text(" Successfullty added"),
      
      ], 
            
    ));
    return mysnackbar;
  }
}

studentAdder(List data) {
  final student = StudentModel(
      name: data[0],
      age: data[1],
      cls: data[2],
      address: data[3],
      img: data[4]);
  addStudent(student);
  findClear();
}

findClear() {
    _nameController.clear();
     _AgeController.clear();
     _ClassController.clear();
     _AddressController.clear();
}

String ErrorCheck(List data) {
  String field = "";
  
  if (data[0].isEmpty &&
      data[1].isEmpty &&
      data[2].isEmpty &&
      data[3].isEmpty) {
    field = "Every field";
    return field;
  } else if (data[0].isEmpty) {
    return field = "name";
  } else if (data[1].isEmpty) {
    return field = "Age";
  } else if (data[2].isEmpty) {
    return field = "Number";
  } else if (data[3].isEmpty) {
    return field = "Division";
  } else if (data[4]==null) {
    return field = "Image";
  } else {
    return field = "success";
  }
}

}