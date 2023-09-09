import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masys_educare/Admin/Dashbord%20List/enquiry.dart';
import 'package:masys_educare/Admin/Notice/adminnotice.dart';
import 'package:masys_educare/Admin/Staff/staffscreen.dart';
import 'package:masys_educare/Admin/Whatsapp/batches.dart';
import 'package:masys_educare/Menu/assignment_state.dart';
import 'package:masys_educare/Menu/lecture_attendence.dart';
import 'package:masys_educare/Menu/lecture_timetable.dart';
import 'package:masys_educare/Menu/media.dart';
import 'package:masys_educare/Menu/profilescreen.dart';
import 'package:masys_educare/Menu/remarks.dart';
import 'package:masys_educare/Menu/subjectscreen.dart';
import 'package:masys_educare/Menu/suggestion_screen.dart';
import 'package:masys_educare/Admin/adminpanel.dart';
import 'package:masys_educare/Widget/custom_drawer.dart';
import 'package:masys_educare/Widget/imageslider.dart';
import 'package:masys_educare/Widget/quicklinks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dashbord List/addmission.dart';
import 'Dashbord List/vouchers.dart';
import 'Student/student.dart';
import 'gridviewbuilder.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  int backButtonPressCount = 0;
  String? adminname;
  String? branchaddress;
  String? Std;
  String? branchname;
  String? batch;
  int? Id;
  int? HeadId;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reloadData();
  }

  Future<void> reloadData() async {
    setState(() {
      isLoading = true; // Show loading indicator while reloading data
    });
    await _storeStudentData();
    setState(() {
      isLoading = false; // Hide loading indicator
    });
  }

  Future<void> _storeStudentData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    adminname = pref.getString("AdminName");
    branchname = pref.getString("BranchName");
    branchaddress = pref.getString("Branchaddres");
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
          backgroundColor: Color(0XFF7292CF),
          elevation: 0,
          title: const Text('Masys Educare'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminPannelscreen()),
                      (route) => false);
                },
                icon: SizedBox(
                    height: 25,
                    child: Image.asset("assets/Icon/switch-user.png"))),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0XFF7292CF),
                      Color(0XFF2855AE),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      _buildStudentInfoCard(context),
                      const SizedBox(height: 20),
                      const ImageSliderWithDots(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Or any other alignment
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Or any other alignment
                  children: [
                    _gridview(),
                    _horizontalrow(),
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
    );
  }

  Widget _horizontalrow() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentDataScreen()));
              },
              child: Container(
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
                      "assets/img.png",
                      scale: 4,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Student",
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
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Staffscreen()));
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
                      "assets/adminlogo/team.png",
                      scale: 4,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Staff",
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BatcheScreen()));
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
                      "assets/whatsapp.png",
                      scale: 4,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Whatsapp",
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminNotice()));
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
                      "assets/notification.png",
                      scale: 4,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Notice",
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                "${adminname}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "Branch : ${branchname}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 30,
          )
        ],
      ),
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
                                  builder: (context) =>
                                      const SuggestionScreen()));
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
                            const Text(
                              "Suggestion",
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MediaScreen()));
                        },
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
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Subjectscreen()));
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
                        onTap: () {},
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
  Widget _gridview() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GridItem(
              title: 'Admission',
              color: Colors.blue,
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardListScreen()));
              },
              icon: Icons.school,
            ),
            GridItem(
              title: 'Vouchers',
              color: Colors.green,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VoucherScreen()));
              },
              icon: Icons.card_giftcard,
            ),

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GridItem(
              title: 'Fees',
              color: Colors.orange,
              onTap: () {
                // Handle Fees item tap here
              },
              icon: Icons.money,
            ),
            GridItem(
              title: 'Enquiry',
              color: Colors.red,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EnquiryScreen()));
              },
              icon: Icons.question_answer,
            ),
          ],
        )
      ],
    );
  }
}
