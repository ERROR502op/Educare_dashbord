import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../Webservice model/getonlinelecture.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Getonlinelecture> lectures = [];
  List<DateTime> lectureDates = [];


  @override
  void initState() {
    super.initState();

  }



  List<Getonlinelecture> getLecturesForSelectedDate(DateTime selectedDate) {
    return lectures.where((lec) {
      DateTime lectureDate = DateFormat("dd/MM/yyyy").parse(lec.dateText);
      return isSameDay(lectureDate, selectedDate);
    }).toList();
  }
  bool hasLecturesForDate(DateTime date) {
    return lectureDates.any((lectureDate) => isSameDay(lectureDate, date));
  }

  Widget buildTableCell(BuildContext context, DateTime date, {required bool isToday}) {
    DateTime now = DateTime.now();
    bool isSame = isSameDay(date, now);
    bool isBefore = date.isBefore(now);

    Color bgColor = Colors.green; // Default color for upcoming lectures
    Color textColor = Colors.white;

    if (isSame) {
      bgColor = Colors.orange; // Orange color for same day
    } else if (isBefore) {
      bgColor = Colors.red;
    }

    if (!hasLecturesForDate(date)) {
      bgColor = Colors.grey.shade300;
      textColor = Colors.black;
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
    List<Getonlinelecture> selectedLectures =
    getLecturesForSelectedDate(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [

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
                defaultBuilder: (context, date, _) => buildTableCell(context, date, isToday: false),
                selectedBuilder: (context, date, _) => buildSelectedTableCell(context, date),
                todayBuilder: (context, date, _) => buildTableCell(context, date, isToday: true),
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
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(fontSize: 10),
                selectedTextStyle: TextStyle(fontSize: 10),
                todayTextStyle: TextStyle(fontSize: 10),
              ),
            ),


            const Divider(),
            if (selectedLectures.isEmpty)
              const CircularProgressIndicator()
            else if (selectedLectures.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: selectedLectures.length,
                  itemBuilder: (context, index) {
                    final lec = selectedLectures[index];
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Container(
                        // Set the calculated container height
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
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
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      child: Text(
                                        lec.lecture,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Time: ${lec.lectTiming}',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Text(
                                "FACULTY: ${lec.facultyName}",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade700),
                              ),
                              Text(
                                "Date: ${lec.dateText}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Divider(),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Topic Remarks: ${lec.topicName}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey.shade700),
                                ),
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
                child: Center(
                  child: Text(
                    "No lectures scheduled for the selected date.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
