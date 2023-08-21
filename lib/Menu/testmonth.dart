import 'package:flutter/material.dart';
import 'package:masys_educare/Menu/test_result.dart';
import 'package:masys_educare/Menu/test_schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Webservice model/testschedule.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class TestMonthScreen extends StatefulWidget {
  final String? result;

  const TestMonthScreen({super.key, this.result});

  @override
  State<TestMonthScreen> createState() => _TestMonthScreenState();
}

class _TestMonthScreenState extends State<TestMonthScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test_schedule();
  }

  List<TestSchedule> testSchedule = [];

  // ignore: non_constant_identifier_names
  Future<void> test_schedule() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headid = pref.getInt("Head_Id");
    // ignore: non_constant_identifier_names
    var Id = pref.getInt("Id");
    var stdid = pref.getString("Std_id");
    var batchid = pref.getString("Batch_id");

    const url = "https://masyseducare.com/masyseducarestudents.asmx/TestMonth";
    final body = {
      "Type": "Student",
      "Head_Id": headid.toString(),
      "Subhead_Id": Id.toString(),
      "Std_Id": stdid,
      "Batch_Id": batchid
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      // ignore: deprecated_member_use
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = testScheduleFromJson(dataString);

      setState(() {
        testSchedule = jsonData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test Summary'),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: testSchedule.isNotEmpty ? testSchedule.length : 1,
                  // Ensure at least one item for the indicator
                  itemBuilder: (context, index) {
                    if (testSchedule.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(), // Show circular progress indicator
                      );
                    } else {
                      final schedule = testSchedule[index];
                      if (schedule.monthName == 'August') {
                        // You can change this condition based on the selected month
                        return InkWell(
                          onTap: () {
                            if (widget.result == "result") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TestResultScreen(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TestSchedulescreen(
                                    testmonth: schedule,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade900,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0,2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                schedule.monthName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward,color: Colors.white,),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink(); // Hide items for other months
                      }
                    }
                  },
                )

            ),
          ],
        ));
  }
}
