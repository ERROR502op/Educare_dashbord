import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../Webservice model/testAttendance.dart';

class TestAttendence extends StatefulWidget {
  const TestAttendence({super.key});

  @override
  State<TestAttendence> createState() => _TestAttendenceState();
}

class _TestAttendenceState extends State<TestAttendence> {
  // Sample data
  List<TestAttendance> testAttendence = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _testAttendance();
  }

  Future<void> _testAttendance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // ignore: non_constant_identifier_names
    var Id = pref.getInt("Id");

    const url =
        "https://masyseducare.com/masyseducarestudents.asmx/TestAttendance";
    final body = {
      "ID": Id.toString(),
    };

    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      // ignore: deprecated_member_use
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = testAttendanceFromJson(dataString);

      setState(() {
        testAttendence = jsonData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade50,
        appBar: AppBar(
          title: const Text("Test Attendence"),
        ),
        body: ListView.builder(
          itemCount: testAttendence.length,
          itemBuilder: (context, index) {
            final test = testAttendence[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Test Date: ${test.dateText}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Card(
                        color: test.attendance == "Present" ? Colors.green.shade500 : Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            test.attendance,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      Text("Subject: ${test.testSubject}"),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
