import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masys_educare/Admin/Whatsapp/showwhatsapp_bottomsheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../Admin Webservice/contact_student.dart';

class StudentWithBatchID extends StatefulWidget {
  final int batchId;
  const StudentWithBatchID({Key? key, required this.batchId}) : super(key: key);

  @override
  State<StudentWithBatchID> createState() => _StudentWithBatchIDState();
}

class _StudentWithBatchIDState extends State<StudentWithBatchID> {
  List<Contactstudent> students = [];
  XFile? Whastappfile;

  Set<Contactstudent> selectedStudents = Set<Contactstudent>();
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    contactstudent();
  }

  void toggleStudentSelection(Contactstudent student) {
    setState(() {
      if (selectedStudents.contains(student)) {
        selectedStudents.remove(student);
      } else {
        selectedStudents.add(student);
      }
    });
  }

  Future<void> contactstudent() async {
    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/GetStudentsWithBatchId";
    final body = {
      "Batch_Id": widget.batchId.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        students = contactstudentFromJson(response.body);
      });
    }
  }
  Future<void> sendwhatsappmessage() async {
    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/SendWhatsappMessage";
    final body = {
    "id":"",
    "numbers":"",
    "text":"",
    "fileextension":"",
    "fileurl":"",
    "filetype":"",
    "orgid":""
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        students = contactstudentFromJson(response.body);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Contacts'),
        actions: [
          Row(
            children: [
              Text("Select All"),
              IconButton(
                icon: Icon(selectAll
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                onPressed: () {
                  setState(() {
                    if (selectAll) {
                      selectedStudents.clear(); // Deselect all
                    } else {
                      selectedStudents.addAll(students); // Select all
                    }
                    selectAll = !selectAll; // Toggle selectAll
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: students.isEmpty
          ? Center(child: Image.asset('assets/emptyimage.png')) // Replace 'empty_image.png' with your image asset path
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          final isSelected = selectedStudents.contains(student);

          return ListTile(
            title: Text('${student.firstName} ${student.lastName}'),
            subtitle: Text(student.fatherMobile),
            trailing: Checkbox(
              value: isSelected,
              onChanged: (value) {
                toggleStudentSelection(student);
              },
            ),
          );
        },
      ),

      floatingActionButton: selectedStudents
              .isNotEmpty // Show the FAB if at least one student is selected
          ? FloatingActionButton  (
              onPressed: () {
                ShowWhatsAppBottomSheet(context);
              },
              child: Image.asset('assets/whatsapp.png'),
            )
          : null,
    );
  }
  void ShowWhatsAppBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Send WhatsApp Message',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file, size: 24),
                    onPressed: () {
                      _showAttachmentOptions(context);
                    },
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement sending message logic here
                },
                child: Text('Send'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAttachmentOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Attach File'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                _pickImageFromCamera(context);
              },
              child: Row(
                children: [
                  Icon(Icons.add_photo_alternate),
                  SizedBox(width: 8),
                  Text('Add Photo'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                _pickImageFromGallery(context);
              },
              child: Row(
                children: [
                  Icon(Icons.insert_drive_file),
                  SizedBox(width: 8),
                  Text('Select From Gallery'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                _pickDocument(context);
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Add Documents'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Cancel'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _pickImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    Whastappfile = await picker.pickImage(source: ImageSource.camera);
    if (Whastappfile != null) {
      // Handle the picked image (you can save, display, or send it)
      // You can access the image file using pickedFile.path
    }
  }

  void _pickImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
     Whastappfile = await picker.pickImage(source: ImageSource.gallery);
    if (Whastappfile != null) {
      // Handle the picked image (you can save, display, or send it)
      // You can access the image file using pickedFile.path
    }
  }

  void _pickDocument(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Handle the picked document (you can save, display, or send it)
      // You can access the document file using result.files.single.path
    }
  }
}

