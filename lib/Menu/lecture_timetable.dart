import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../Webservice model/getonlinelecture.dart';

class LectureTimeable extends StatefulWidget {
  const LectureTimeable({super.key});

  @override
  State<LectureTimeable> createState() => _LectureTimeableState();
}

class _LectureTimeableState extends State<LectureTimeable> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Getonlinelecture> lectures = [];
  List<DateTime> lectureDates = [];

  @override
  void initState() {
    super.initState();
    getOnlineLecture();
  }

  Future<void> getOnlineLecture() async {
    setState(() {});
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headId = pref.getInt("Head_Id");
    // ignore: non_constant_identifier_names
    var ID = pref.getInt("Id");
    var stdId = pref.getString("Std_id");
    var batchId = pref.getString("Batch_id");

    const url =
        "https://masyseducare.com/masyseducarestudents.asmx/LectureDaywise";
    final body = {
      "Head_Id": headId.toString(),
      "Subhead_Id": ID.toString(),
      "Std_Id": stdId,
      "Batch_Id": batchId,
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      // ignore: deprecated_member_use
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = getonlinelectureFromJson(dataString);

      setState(() {
        lectures = jsonData;
        lectureDates = jsonData
            .map((lec) => DateFormat("dd/MM/yyyy").parse(lec.dateText))
            .toList();
      });
    }
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

  Widget buildTableCell(BuildContext context, DateTime date,
      {required bool isToday}) {
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
      bgColor = Colors.red.shade50;
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
        title: const Text("Lecture Timetable"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLectureSection("Past lectures", Colors.red),
                buildLectureSection("Today's   lectures", Colors.orange),
                buildLectureSection("Upcoming lectures", Colors.green),
                buildLectureSection(
                    "Selected lectures", Colors.purple.shade900),
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
                getOnlineLecture();
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
            if (lectures.isEmpty)
              const Center(child: CircularProgressIndicator())
            else if (selectedLectures.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: selectedLectures.length,
                  itemBuilder: (context, index) {
                    final lec = selectedLectures[index];
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
                                        lec.lecture,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '🕒: ${lec.lectTiming}',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Text(
                                lec.topicName,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "By: ${lec.facultyName}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700),
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
