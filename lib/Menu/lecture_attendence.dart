import 'package:flutter/material.dart';
import 'package:masys_educare/Webservice%20model/holiday.dart';
import 'package:masys_educare/Webservice%20model/lec_present.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../Webservice model/getonlinelecture.dart';

class LectureAttendancescreen extends StatefulWidget {
  const LectureAttendancescreen({super.key});

  @override
  State<LectureAttendancescreen> createState() => _LectureAttendancescreenState();
}

class _LectureAttendancescreenState extends State<LectureAttendancescreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<LecPresent> lecattendace = [];
  List<Holiday> holiday = [];
  List<DateTime> lectureDates = [];
  List<DateTime> holidayDates = [];

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var ID = pref.getInt("Id");
    var headId = pref.getInt("Head_Id");
    var stdId = pref.getString("Std_id");
    var batchId = pref.getString("Batch_id");

    const url = "https://masyseducare.com/masyseducarestudents.asmx/Attendance";
    final presentBody = {
      "ID": ID.toString(),
      "Status": "Present",
    };

    final absentBody = {
      "ID": ID.toString(),
      "Status": "Absent",
    };

    const holidayUrl = "https://masyseducare.com/masyseducarestudents.asmx/Holiday_New";
    final holidayBody = {
      "Head_Id": headId.toString(),
      "Subhead_Id": ID.toString(),
      "Std_Id": stdId,
      "Batch_Id": batchId,
    };

    final presentResponse = await http.post(Uri.parse(url), body: presentBody);
    final absentResponse = await http.post(Uri.parse(url), body: absentBody);
    final holidayResponse = await http.post(Uri.parse(holidayUrl), body: holidayBody);

    if (presentResponse.statusCode == 200 && absentResponse.statusCode == 200) {
      final presentXmlDoc = xml.XmlDocument.parse(presentResponse.body);
      final presentDataString = presentXmlDoc.findAllElements('string').first.text;
      final absentXmlDoc = xml.XmlDocument.parse(absentResponse.body);
      final absentDataString = absentXmlDoc.findAllElements('string').first.text;

      final presentData = lecPresentFromJson(presentDataString);
      final absentData = lecPresentFromJson(absentDataString);

      final allAttendanceData = [...presentData, ...absentData];

      setState(() {
        lecattendace = allAttendanceData;
        lectureDates = allAttendanceData
            .map((lec) => DateFormat("dd/MM/yyyy").parse(lec.dateOn))
            .toList();
      });
    }

    if (holidayResponse.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(holidayResponse.body);
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = holidayFromJson(dataString);

      setState(() {
        holiday = jsonData;
        holidayDates = jsonData
            .map((lec) => DateFormat("dd/MM/yyyy").parse(lec.dateOn))
            .toList();
      });
    }
  }


  List<LecPresent> getLecturesForSelectedDate(DateTime selectedDate) {
    return lecattendace.where((lec) {
      DateTime lectureDate = DateFormat("dd/MM/yyyy").parse(lec.dateOn);
      return isSameDay(lectureDate, selectedDate);
    }).toList();
  }
  List<Holiday> getHolidayForSelectedDate(DateTime selectedDate) {
    return holiday.where((lec) {
      DateTime lectureDate = DateFormat("dd/MM/yyyy").parse(lec.dateOn);
      return isSameDay(lectureDate, selectedDate);
    }).toList();
  }

  bool hasLecturesForDate(DateTime date) {
    return lectureDates.any((lectureDate) => isSameDay(lectureDate, date));
  }
  bool isDateHoliday(DateTime date) {
    return holidayDates.any((lectureDate) => isSameDay(lectureDate, date));
  }

  Widget buildTableCell(BuildContext context, DateTime date, {required bool isToday}) {
    bool isStudentPresent = hasLecturesForDate(date);
    bool isHoliday = isDateHoliday(date);

    Color bgColor = Colors.red.shade50; // Default color for dates with no attendance
    Color textColor = Colors.black;

    if (isHoliday) {
      bgColor = Colors.orange; // Color for holiday dates
    } else if (isStudentPresent) {
      var lecturesForDate = getLecturesForSelectedDate(date);
      var hasPresentStatus = lecturesForDate.any((lec) => lec.status == "Present");
      var hasAbsentStatus = lecturesForDate.any((lec) => lec.status == "Absent");

      if (hasPresentStatus && hasAbsentStatus) {
        bgColor = Colors.orange; // Color for dates with both "Present" and "Absent" statuses
      } else if (hasPresentStatus) {
        bgColor = Colors.green; // Color for dates with "Present" status
        textColor = Colors.white;
      } else if (hasAbsentStatus) {
        bgColor = Colors.red; // Color for dates with "Absent" status
        textColor = Colors.white;
      }
    }

    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget buildSelectedTableCell(BuildContext context, DateTime date) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple, // Dark purple color for selected date
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<LecPresent> selectedLectures =
    getLecturesForSelectedDate(_selectedDay);
    List<Holiday> holidayupdate =
    getHolidayForSelectedDate(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lecture Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLectureSection("Present", Colors.green),
                buildLectureSection("Absent", Colors.red),
                buildLectureSection("Holiday", Colors.orange),
                buildLectureSection(
                    "Selected Date", Colors.purple.shade900)

              ],
            ),


            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, _) =>
                    buildTableCell(context, date, isToday: false),
                selectedBuilder: (context, date, _) =>
                    buildSelectedTableCell(context, date),
                todayBuilder: (context, date, _) =>
                    buildTableCell(context, date, isToday: true),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });

                // Call the function to fetch lecture data based on selected date
                fetchAttendance();
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: const CalendarStyle(
                // Adjust the fontSize property to your desired text size
                defaultTextStyle: TextStyle(fontSize: 10),
                // Change the font size as needed
                selectedTextStyle: TextStyle(fontSize: 10),
                todayTextStyle: TextStyle(fontSize: 10),
              ),
            ),
            const Divider(),
            if (lecattendace.isEmpty || holiday.isEmpty)
              const Center(child: CircularProgressIndicator())
            else if (selectedLectures.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: selectedLectures.length,
                  itemBuilder: (context, index) {
                    final lec = selectedLectures[index];
                    return Container(
                      // Set the calculated container height
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  color: lec.status == "Present" ? Colors.green : Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    child: Text(
                                      lec.status,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("${lec.dateOn}"),
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            else if (holiday.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: holidayupdate.length,
                  itemBuilder: (context, index) {
                    final holi = holidayupdate[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        // Set the calculated container height
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      child: Text(
                                        holi.discription,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "All Empty Here !",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Looks like don't have any lecture today",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildLectureSection(String title, Color circleColor) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: circleColor,
          radius: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(title),
        )
      ],
    );
  }
}
