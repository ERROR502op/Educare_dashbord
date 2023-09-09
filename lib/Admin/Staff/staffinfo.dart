import 'package:flutter/material.dart';
import 'package:masys_educare/Admin/Staff/staff_detail.dart';
import 'package:masys_educare/Admin/Staff/staffattendance.dart';
import 'package:masys_educare/Admin/Staff/stafflecture.dart';
import '../Student/attendanceadmin.dart';
import '../Student/msg_to_parent.dart';

class StaffInfoScreen extends StatefulWidget {
  final String staffname;
  const StaffInfoScreen({super.key, required this.staffname});

  @override
  State<StaffInfoScreen> createState() => _StaffInfoScreenState();
}

class _StaffInfoScreenState extends State<StaffInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.staffname,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Attendance'),
              Tab(text: 'Lecture'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Detailscreen
            StaffDetail(),
            // Contents
            StaffAttendance(),
            // Contents of Tab 3
            StaffLecture()
          ],
        ),
      ),
    );
  }
}
