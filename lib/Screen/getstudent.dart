// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:masys_educare/Screen/homepage(student).dart';
import 'package:masys_educare/Webservice%20model/getadmin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;
import '../Webservice model/getstudent.dart';

class GetStudentscreen extends StatefulWidget {
  const GetStudentscreen({super.key});

  @override
  State<GetStudentscreen> createState() => _GetStudentscreenState();
}

class _GetStudentscreenState extends State<GetStudentscreen> {
  List<Getstudent> getstudent = [];

  String? Phonenumber;
  int backButtonPressCount = 0;

  @override
  void initState() {
    super.initState();
    getstudentdetails();
  }

  Future<void> getstudentdetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var Role = pref.getString("role");
    Phonenumber = pref.getString("phonenumber");

    const studenturl =
        "https://masyseducare.com/masyseducarestudents.asmx/GetStudents";
    final studentbody = {
      "Mobile": Phonenumber,
      "Role": Role,
    };

    final studentresponse =
        await http.post(Uri.parse(studenturl), body: studentbody);

    if (studentresponse.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(studentresponse.body);
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = getCateoryFromJson(dataString);

      setState(() {
        getstudent = jsonData;
      });
      _openBottomSheet(context);
    }

  }
  Future<bool> _onWillPop() async {
    if (backButtonPressCount == 0) {
      // Show a toast message when back button is pressed once
      Fluttertoast.showToast(
        msg: 'Press back again to minimize the app',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      backButtonPressCount++;
      // Reset the backButtonPressCount after a certain duration (e.g., 2 seconds)
      Future.delayed(const Duration(seconds: 2), () {
        backButtonPressCount = 0;
      });
      return false;
    } else {
      // If back button is pressed again, minimize the app
      return true;
    }
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: getstudent.isEmpty
                  ? const Center(
                      child:
                          CircularProgressIndicator(), // Show CircularProgressIndicator if getstudent list is empty
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            "Select Student",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: getstudent.length,
                            itemBuilder: (context, index) {
                              final student = getstudent[index];
                              return InkWell(
                                onTap: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString("FullName",
                                      "${student.firstName} ${student.lastName}");
                                  pref.setString(
                                      "StudentId", student.studentId);
                                  pref.setInt("Id", student.id);
                                  pref.setString("Std_id", student.stdId);
                                  pref.setInt("Srno", student.id);
                                  pref.setString("Head_Name", student.headName);
                                  pref.setInt("Head_Id", student.headId);
                                  pref.setString(
                                      "Sunhead_name", student.subheadName);
                                  pref.setString(
                                      "SuBhead_id", student.subheadId);
                                  pref.setString("Batch_id", student.batchId);
                                  pref.setString("StdName", student.stdName);
                                  pref.setString(
                                      "Batch_Name", student.batchName);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomePage(getstudent: student)),
                                      (route) => false);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.purple.shade100,
                                          Colors.purple.shade900
                                        ],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                'https://static.vecteezy.com/system/resources/previews/000/618/556/original/education-logo-vector-template.jpg'),
                                          ),
                                          const SizedBox(width: 14),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${student.firstName} ${student.lastName}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(height: 8),
                                              Text('ID: ${student.studentId}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              Text('Class: ${student.stdName}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              Text(
                                                  'Batch: ${student.batchName}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
        ); // Your custom bottom sheet widget
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Masys Educare',
          ),
        ),
      ),
    );
  }
}
