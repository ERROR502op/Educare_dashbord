import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masys_educare/Webservice%20model/testresult_data.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TestResultaadmin extends StatefulWidget {
  const TestResultaadmin({Key? key}) : super(key: key);

  @override
  State<TestResultaadmin> createState() => _TestResultaadminState();
}

class _TestResultaadminState extends State<TestResultaadmin> {
  List<TestResult> testData = []; // To store fetched data
  bool isLoading = true; // To control loading indicator visibility

  @override
  void initState() {
    super.initState();
    getTestResult();
  }

  Future<void> getTestResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("Id");
    const url =
        "https://masyseducare.com/masyseducarestudents.asmx/GetTestResults";
    final body = {
      "Student_Id": id.toString(),
      "MonthName": "August",
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        testData = testResultFromJson(response.body);
        isLoading = false; // Data is loaded, so set isLoading to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(), // Show loading indicator
      )
          : (testData.isEmpty
          ? const Center(
        child: Text('No test results available.'),
      )
          : ListView.builder(
        itemCount: testData.length,
        itemBuilder: (context, index) {
          final item = testData[index];
          return Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Card(
                        color: Colors.green.shade500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.result,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(
                        "${item.marksObtained} / ${item.maxMarks}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.subName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                      ),
                      Text(
                        "Remark: ${item.resultRemark}",
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade700),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
