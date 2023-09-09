import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:masys_educare/Model/mytheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Admin Webservice/studentinfo.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  final String? ContactID;

  const DetailsScreen({super.key, this.ContactID});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<StudentInfo> studentInfo = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudentInfo();
  }

  Future<void> getStudentInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ID = prefs.getInt("ContactID");
    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/GetStudentsDetails";
    final body = {
      "ID": ID.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        studentInfo = studentInfoFromJson(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: studentInfo.length,
        itemBuilder: (BuildContext context, int index) {
          final student = studentInfo[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  "Personal Information",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColorTheme.primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  elevation: 0,
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Name :'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Gender: '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('DOB: '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('School Name: '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Standard: '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Batch Name: '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Academic Year:'),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${student.firstName ?? 'NA'} ${student.lastName ?? 'NA'}'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${student.gender ?? 'NA'}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${student.dobConvert ?? 'NA'}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${student.schoolCollege ?? 'NA'}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text('${student.stdName.isNotEmpty ?? 'NA'}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text('${student.batchName.isNotEmpty ?? 'NA'}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${student.academicYear ?? 'NA'}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  "Parent Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColorTheme.primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        elevation: 0,
                        color: Colors.grey.shade200,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                          ),
                          title: Text(
                            "${student.fatherName ?? 'NA'}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("${student.fatherMobile ?? 'NA'}"),
                          trailing: IconButton(
                            onPressed: () async {
                              launch('tel://${student.fatherMobile}');
                            },
                            icon: Icon(Icons.phone),
                          ),
                        )),
                    if (student.motherName != null && student.motherName.isNotEmpty)
                    Card(
                        elevation: 0,
                        color: Colors.grey.shade200,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                          ),
                          title: Text(
                            "${student.motherName ?? 'NA'}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("${student.motherMobile ?? 'NA'}"),
                          trailing: IconButton(
                            onPressed: () {
                              launch('tel://${student.motherMobile}');
                            },
                            icon: Icon(Icons.phone),
                          ),
                        )),
                    if (student.address != null && student.address.isNotEmpty)
                      Card(
                        elevation: 0,
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Address: ${student.address}"),
                        ),
                      ),

                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final url = 'https://masyseducare.com/App_Pages/Fees_Payment.aspx?ID=${student.id}&UID=${student.uuid}';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: MyColorTheme.primaryColor,
                          // Background color
                          onPrimary: Colors.white,
                          // Text color
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Pay Fees',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
