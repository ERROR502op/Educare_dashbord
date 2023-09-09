import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:masys_educare/Admin/Admin%20Webservice/studentcontact.dart';
import 'package:masys_educare/Admin/Staff/staffinfo.dart';
import 'package:masys_educare/Admin/Student/studentinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../Admin Webservice/staffdata.dart';
import '../Admin Webservice/studentinfo.dart';

class Staffscreen extends StatefulWidget {
  const Staffscreen({Key? key}) : super(key: key);

  @override
  State<Staffscreen> createState() => _StaffscreenState();
}

class _StaffscreenState extends State<Staffscreen> {
  // Sample student data for demonstration
  List<StaffData> stafflist = [];
  String _searchQuery = '';
  List<StaffData> _filteredStudentList = [];


  void updateFilteredList() {
    if (_searchQuery.isEmpty) {
      _filteredStudentList = stafflist;
    } else {
      _filteredStudentList = stafflist.where((student) {
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
        "https://masyseducare.com/masyseducareadmin.asmx/GetStaffList";
    final body = {
      "UID":"96",
      "B_Code": B_Code.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = staffDataFromJson(dataString);
      setState(() {
        stafflist = jsonData ;
        _filteredStudentList = stafflist;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff'),
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
                final staff = _filteredStudentList[index];


                return InkWell(
                  onTap: ()async{
                    SharedPreferences pref=await SharedPreferences.getInstance();
                    setState(() {
                      pref.setInt("StaffId", staff.userId);
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffInfoScreen(staffname: '${staff.firstName} ${staff.lastName}',)));
                  },
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text("${staff.firstName} ${staff.lastName}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${staff.mobileForSms}"),
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

