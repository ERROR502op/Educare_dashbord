import 'package:flutter/material.dart';
import 'package:masys_educare/Admin/Student/attendanceadmin.dart';
import 'package:masys_educare/Admin/Student/deatils.dart';
import 'package:masys_educare/Admin/Student/msg_to_parent.dart';
import 'package:masys_educare/Admin/Student/paymentscreenadmin.dart';
import 'package:masys_educare/Admin/Student/testresultadmin.dart';


class StudentDetailsScreen extends StatefulWidget {
  final String studentname;

 StudentDetailsScreen({super.key, required this.studentname,});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.studentname,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Attendance'),
              Tab(text: 'Message'),
              Tab(text: 'Payment'),
              Tab(text: 'Test Result'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Detailscreen
            DetailsScreen(),
            // Contents
            Attendanceadmin(),
            // Contents of Tab 3
            MessageToParent(),
            // Contents of Tab 4
            PaymentScreen(),
            // Contents of Tab 5
            TestResultaadmin()
          ],
        ),
      ),
    );
  }
}
