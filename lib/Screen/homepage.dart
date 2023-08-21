// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masys_educare/Menu/assignment_state.dart';
import 'package:masys_educare/Menu/emergency.dart';
import 'package:masys_educare/Menu/fees_summary.dart';
import 'package:masys_educare/Menu/lecture_attendence.dart';
import 'package:masys_educare/Menu/lecture_timetable.dart';
import 'package:masys_educare/Menu/notes.dart';
import 'package:masys_educare/Menu/notice.dart';
import 'package:masys_educare/Menu/profilescreen.dart';
import 'package:masys_educare/Menu/raise_doubt.dart';
import 'package:masys_educare/Menu/remarks.dart';
import 'package:masys_educare/Menu/suggestion_screen.dart';
import 'package:masys_educare/Menu/test_attendence.dart';
import 'package:masys_educare/Menu/testmonth.dart';
import 'package:masys_educare/Screen/getstudent.dart';
import 'package:masys_educare/Webservice%20model/getstudent.dart';
import 'package:masys_educare/Widget/custom_drawer.dart';
import 'package:masys_educare/Widget/imageslider.dart';
import 'package:masys_educare/Widget/quicklinks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Getstudent getstudent;

  HomePage({required this.getstudent});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int backButtonPressCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeStudentData();
  }
  void _showToast() {
    Fluttertoast.showToast(
      msg: 'Coming soon !',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade900,
      textColor: Colors.white,
    );
  }

  void _storeStudentData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("FullName", "${widget.getstudent.firstName} ${widget.getstudent.lastName}");
    pref.setString("StudentId", widget.getstudent.studentId);
    pref.setInt("Id", widget.getstudent.id);
    pref.setString("Std_id", widget.getstudent.stdId);
    pref.setInt("Srno", widget.getstudent.id);
    pref.setString("Head_Name", widget.getstudent.headName);
    pref.setInt("Head_Id", widget.getstudent.headId);
    pref.setString("Sunhead_name", widget.getstudent.subheadName);
    pref.setString("SuBhead_id", widget.getstudent.subheadId);
    pref.setString("Batch_id", widget.getstudent.batchId);
    pref.setString("StdName", widget.getstudent.stdName);
    pref.setString("Batch_Name", widget.getstudent.batchName);
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



  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0XffE1F6FB),
        drawer: const CustomDrawer(),
        appBar: AppBar(
          elevation: 0,
          title: const Text('Masys Educare'),
          actions: [
            // Add your user login logo here as an IconButton or any other widget
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GetStudentscreen()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.switch_account_sharp,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _buildStudentInfoCard(context),
                const SizedBox(height: 20),
                const ImageSliderWithDots(),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      _horizontalrow(),
                      _buildGridView(),
                      activity(),
                      const QuickLinks(),
                      const SizedBox(height: 10)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _horizontalrow() {
    return Container(
      color: const Color(0XffE1F6FB),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.41,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/Icon/home.png",
                    scale: 4,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Home",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(
                        "(All work)",
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FeeSummaryScreen()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.41,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/Icon/debit-card.png",
                      scale: 4,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          """
Fees""",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        Text(
                          "(Daily Updates)",
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.41,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/Icon/user.png",
                      scale: 4,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        Text(
                          "(User Profile)",
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentInfoCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.blue.shade900],
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                'https://static.vecteezy.com/system/resources/previews/000/618/556/original/education-logo-vector-template.jpg',
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.getstudent.firstName}  ${widget.getstudent.lastName}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ID: ${widget.getstudent.studentId}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Class: ${widget.getstudent.stdName}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Batch: ${widget.getstudent.batchName}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Test & Exam",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap:(){
                          _showToast();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 0.1),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Icon/test.png",
                                scale: 4,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Mock Test",
                                style: TextStyle(fontSize: 11),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TestMonthScreen()));
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 0.1),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Icon/shedule.png",
                                scale: 4,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Test\n Schedule",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 11),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TestAttendence()));
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 0.1),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Icon/immigration.png",
                                scale: 4,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Test \n Attendence",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 11),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TestMonthScreen(
                                        result: "result",
                                      )));
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 0.1),
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Icon/medical-result.png",
                                scale: 4,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Test \n Result",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 11),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade200,
                          Colors.orange.shade500
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Emergency Circular",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Emergencyscreen()));
                                },
                                child: const Text(
                                  'Check Now',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          "assets/Icon/siren.png",
                          scale: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade200,
                          Colors.purple.shade500
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Notice Update",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NoticeBoradScreen()));
                                },
                                child: const Text(
                                  'Check Now',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          "assets/image/alert.png",
                          scale: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget activity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            "Manage App",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Card(
          color: Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LectureTimeable()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/Icon/timetable.png",
                              scale: 4,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Lecture Timetable",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LectureAttendancescreen()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/Icon/attendance.png",
                              scale: 4,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Lecture Attendence",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AssignmentScreenState()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/Icon/assignment.png",
                              scale: 4,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Assignment",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SuggestionScreen()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/image/idea.png",
                              scale: 4,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Suggestion",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/Icon/folder.png",
                            scale: 4,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Media",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Notesscreen()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/image/notebook.png",
                              scale: 4,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Notes",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RemarksScreen()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/image/remark.png",
                              scale: 4,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Remark",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RaiseDoubtScreen(
                                        url:
                                            "https://masyseducare.com/App_Pages/NewDoubt_Student.aspx?uid=${widget.getstudent.id}",
                                      )));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/image/hand.png",
                              scale: 4,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Raise doubts",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
