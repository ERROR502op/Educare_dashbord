import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Admin Webservice/stafflecture.dart';

class StaffLecture extends StatefulWidget {
  const StaffLecture({Key? key}) : super(key: key);

  @override
  _StaffLectureState createState() => _StaffLectureState();
}

class _StaffLectureState extends State<StaffLecture> {
  List<Stafflecture> lectures = [];
  DateTime? fromDate;
  DateTime? toDate;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fromDate = DateTime.now();
    toDate = DateTime.now();
    if (fromDate != null) {
      _fromDateController.text = dateFormat.format(fromDate!);
    }
    if (toDate != null) {
      _toDateController.text = dateFormat.format(toDate!);
    }
    getstaffattendance();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate:
          isFromDate ? fromDate ?? DateTime.now() : toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    setState(() {
      if (isFromDate) {
        fromDate = picked;
        _fromDateController.text = dateFormat.format(picked);
      } else {
        toDate = picked;
        _toDateController.text = dateFormat.format(picked);
      }
    });
    getstaffattendance();
  }

  Future<void> getstaffattendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ID = prefs.getInt("StaffId");
    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/GetLectureScheduleByFromToDate";
    final body = {
      "Teacher_Id": ID.toString(),
      "FromDate": _fromDateController.text,
      "ToDate": _toDateController.text,
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        lectures = stafflectureFromJson(response.body);
      });
    }
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: _fromDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'From Date',
                        suffixIcon: Icon(Icons.calendar_today),
                        border: InputBorder.none,
                      ),
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: _toDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'To Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            lectures.isEmpty
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Looks like no Lecture shedule for today",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Image.asset('assets/emptyimage.png'),
                    ],
                  ) // Show image when lectures are empty
                : Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Today's Lecture:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: lectures.length,
                        itemBuilder: (context, index) {
                          final lec = lectures[index];
                          return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lec.subjectName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("👤 ${lec.teacherName}"),
                                  Text("🗓️ ${lec.dateTxt}"),
                                  Text("⏰ ${lec.fromTime} To ${lec.toTime} ")
                                ],
                              ),
                            ),
                            subtitle: Text(lec.date),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
