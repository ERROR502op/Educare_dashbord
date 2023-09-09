import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:masys_educare/Admin/Admin%20Webservice/studentcontact.dart';
import 'package:masys_educare/Admin/Student/studentinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Admin Webservice/studentinfo.dart';

class StudentDataScreen extends StatefulWidget {
  const StudentDataScreen({Key? key}) : super(key: key);

  @override
  State<StudentDataScreen> createState() => _StudentDataScreenState();
}

class _StudentDataScreenState extends State<StudentDataScreen> {
  // Sample student data for demonstration
  List<Studentcontact> studentList = [];
  String _searchQuery = '';
  List<Studentcontact> _filteredStudentList = [];


  void updateFilteredList() {
    if (_searchQuery.isEmpty) {
      _filteredStudentList = studentList;
    } else {
      _filteredStudentList = studentList.where((student) {
        final fullName = "${student.firstName} ${student.lastName}";
        return fullName.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallstudent();
  }




  Future<void> getallstudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var B_Code = prefs.getInt("B_Code");
    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/GetAllStudents";
    final body = {
      "B_Code": B_Code.toString(),
      "Std_Id": "",
      "Batch_Id": "",
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {

      setState(() {
        studentList = studentcontactFromJson(response.body);
        _filteredStudentList = studentList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Contacts'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.filter))
        ],
      ),
      body: Column(
        children: [
          RoundedSearchBar(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
                updateFilteredList();

              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredStudentList.length,
              itemBuilder: (BuildContext context, int index) {
                final student = _filteredStudentList[index];

                return InkWell(
                  onTap: ()async{
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    setState(() {
                      pref.setInt("ContactID", student.id);
                    });

                    Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentDetailsScreen(studentname: '${student.firstName} ${student.lastName}',)));
                  },
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text("${student.firstName} ${student.lastName}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${student.fatherMobile}"),
                      ],
                    ),
                    // Add any additional onTap functionality here
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedSearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
          color: Colors.grey[200],
        ),
        child: TextField(
          onChanged: onChanged, // Call the provided onChanged function
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}

