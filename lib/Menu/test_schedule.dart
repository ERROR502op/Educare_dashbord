import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masys_educare/Webservice%20model/testdata.dart';
import 'package:masys_educare/Webservice%20model/testschedule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class TestSchedulescreen extends StatefulWidget {
  final TestSchedule testmonth;

  const TestSchedulescreen({Key? key, required this.testmonth})
      : super(key: key);

  @override
  State<TestSchedulescreen> createState() => _TestSchedulescreenState();
}

class _TestSchedulescreenState extends State<TestSchedulescreen> {
  // Sample data
  List<TestData> testData = [];

  DateTime _selectedDate = DateTime.now(); // Initialize with the current date

  @override
  void initState() {
    super.initState();
    _testData();
  }

  Future<void> _testData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headid = pref.getInt("Head_Id");
    var Id = pref.getInt("Id");
    var stdid = pref.getString("Std_id");
    var batchid = pref.getString("Batch_id");

    const url =
        "https://masyseducare.com/masyseducarestudents.asmx/TestSchedule";
    final body = {
      "Type": "Student",
      "Head_Id": headid.toString(),
      "Subhead_Id": Id.toString(),
      "Std_Id": stdid,
      "Batch_Id": batchid,
      "Monthname": widget.testmonth.monthName.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = testDataFromJson(dataString);

      setState(() {
        testData = jsonData;

      });
    }
  }

  String formatDate(String inputDate) {
    final originalFormat = DateFormat('dd/MM/yyyy');
    final newFormat = DateFormat('dd MMM yyyy', 'en_US');

    final date = originalFormat.parseStrict(inputDate); // Use parseStrict
    final formattedDate = newFormat.format(date);

    return formattedDate;
  }

  List<DateTime> getTestDates() {
    List<DateTime> testDates = [];
    for (final test in testData) {
      final testDate = DateFormat('dd/MM/yyyy').parse(test.dateText);
      testDates.add(testDate);
    }
    return testDates;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final DateTime firstSelectableDate =
        currentDate.subtract(const Duration(days: 180 + 30 * 6));
    final DateTime initialDate = _selectedDate;
    final List<DateTime> testDates =
        getTestDates(); // Get the list of test dates

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text("Test Schedule"),
      ),
      body: Column(
        children: [
          CalendarTimeline(
            initialDate: initialDate,
            firstDate: firstSelectableDate,
            // Subtract 6 months and 30 days for previous 6 months
            lastDate: currentDate.add(const Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
            leftMargin: 20,
            monthColor: Colors.blue.shade900,
            dayColor: Colors.teal[200],
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.blue,
            dotsColor: Colors.white,
          ),
          const Divider(),
          Expanded(
            child: testData.isEmpty
                ? const Center(
              child: CircularProgressIndicator(), // Display loading indicator
            )
                : Column(
              children: [
                if (testData.any((test) =>
                    _selectedDate.isAtSameMomentAs(
                        DateFormat('dd/MM/yyyy').parse(test.dateText))))
                  Expanded(
                    child: ListView.builder(
                      itemCount: testData.length,
                      itemBuilder: (context, index) {
                        final test = testData[index];
                        final testDate = DateFormat('dd/MM/yyyy')
                            .parse(test.dateText); // Parse test date from string

                        if (_selectedDate.isAtSameMomentAs(testDate)) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(formatDate(test.dateText)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: const BoxDecoration(color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          test.testSubject,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Card(
                                          color: Colors.green.shade100,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 15),
                                            child: Text(
                                              "Test",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                  Colors.green.shade700,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                      child: Text(
                                        "Topic :${test.topicName}",
                                        style: const TextStyle(fontSize: 15),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                      child: Text(
                                        "Total Marks: ${test.totalMarks}",
                                        style: const TextStyle(fontSize: 15),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                      child: Text(
                                        "🕛 ${test.timing}  (${test.duration})",
                                        style: const TextStyle(fontSize: 14),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink(); // Return an empty widget
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Looks like you don't have any tests for today",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
              ],
            )


          ),
        ],
      ),
    );
  }
}
