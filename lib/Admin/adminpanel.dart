// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:masys_educare/Admin/homepage(admin).dart';
import 'package:masys_educare/Screen/homepage(student).dart';
import 'package:masys_educare/Webservice%20model/getadmin.dart';
import 'package:masys_educare/Webservice%20model/getmedium.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;
import '../Webservice model/getstudent.dart';

class AdminPannelscreen extends StatefulWidget {
  const AdminPannelscreen({super.key});

  @override
  State<AdminPannelscreen> createState() => _AdminPannelscreenState();
}

class _AdminPannelscreenState extends State<AdminPannelscreen> {
  List<GetMedium> getmedium = [];
  List<GetAdmin> getadmin = [];
  String? Phonenumber;
  int backButtonPressCount = 0;

  @override
  void initState() {
    super.initState();
    getadmindetails();
    _getAdmin();
  }

  Future<void> _getAdmin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var Role = pref.getString("role");
    Phonenumber = pref.getString("phonenumber");

    const studenturl =
        "https://masyseducare.com/masyseducareadmin.asmx/GetUserData";
    final studentbody = {
      "UID": "96",
      "Username": Phonenumber,
      "Role": Role,
    };

    final studentresponse =
        await http.post(Uri.parse(studenturl), body: studentbody);

    if (studentresponse.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(studentresponse.body);
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = getAdminFromJson(dataString);

      setState(() {
        getadmin = jsonData;
      });

      for (var admin in getadmin) {
        pref.setString("Firstname", admin.firstName);
        pref.setString("Lastname", admin.lastName);
        pref.setString("AdminName", "${admin.firstName} ${admin.lastName}");
        pref.setInt("User_ID", admin.userId);
        pref.setInt("Org_ID", admin.orgId);
      }
    }
  }

  Future<void> getadmindetails() async {
    const mediumurl =
        "https://masyseducare.com/masyseducareadmin.asmx/GetMedium";
    final mediumbody = {
      "UID": "96",
    };

    final mediumresponse =
        await http.post(Uri.parse(mediumurl), body: mediumbody);

    if (mediumresponse.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(mediumresponse.body);
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = getMediumFromJson(dataString);
      setState(() {
        getmedium = jsonData;
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
                child: getmedium.isEmpty
                    ? const Center(
                        child:
                            CircularProgressIndicator(), // Show CircularProgressIndicator if getstudent list is empty
                      )
                    : ListView.builder(
                        itemCount: getmedium.length,
                        itemBuilder: (context, index) {
                          final medium = getmedium[index];

                          return InkWell(
                            onTap: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setString("BranchName", medium.medium);
                              pref.setString(
                                  "Branchaddres", medium.headAddress);
                              pref.setInt("B_Code", medium.headId);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageAdmin()),
                                  (route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.tealAccent.shade100,
                                      Colors.teal
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
                                            'https://img.freepik.com/free-vector/location_53876-25530.jpg?w=740&t=st=1692792551~exp=1692793151~hmac=5d3b8f2651dffbd56de008d3ab9441beaa5e6e8246407336d89ca79cae14c03c'),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${medium.medium}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Address: ${medium.headAddress}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )));
      },
    );
  }

  Future<void> _initializeAdminData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final adminDataJson = prefs.getString('adminData');
    if (adminDataJson != null) {
      final List<dynamic> adminJsonList = json.decode(adminDataJson);
      setState(() {
        getadmin =
            adminJsonList.map((json) => GetAdmin.fromJson(json)).toList();
      });
    }
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
        body: TextButton(
            onPressed: () {
              _openBottomSheet(context);
            },
            child: Text("okay")),
      ),
    );
  }
}
