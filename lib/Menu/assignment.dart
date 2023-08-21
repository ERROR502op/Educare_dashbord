import 'package:flutter/material.dart';
import 'package:masys_educare/Model/mytheme.dart';
import 'package:masys_educare/Webservice%20model/classwork.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:xml/xml.dart'as xml;

import '../Webservice model/homework.dart';


class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  List<Homework> homework =[];
  List<Classwork> classwork =[];
  bool _showHomework = false;
  bool _showClasswork = false;

  @override
  void initState() {
    super.initState();
    _homework();
    _classwork();
    _showHomework = true;
    _showClasswork = false;
  }

  Future<void> _homework() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headid = pref.getInt("Head_Id");
    // ignore: non_constant_identifier_names
    var ID = pref.getInt("Id");
    var stdid = pref.getString("Std_id");
    var batchid = pref.getString("Batch_id");


    const url = "https://masyseducare.com/masyseducarestudents.asmx/Homework";
    final body = {
      "Head_Id":headid.toString(),
      "Subhead_Id":ID.toString(),
      "Std_Id":stdid,
      "Batch_Id":batchid
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      // ignore: deprecated_member_use
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = homeworkFromJson(dataString);

      setState(() {
        homework = jsonData;
      });
    }
  }
  Future<void> _classwork() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headid = pref.getInt("Head_Id");
    // ignore: non_constant_identifier_names
    var ID = pref.getInt("Id");
    var stdid = pref.getString("Std_id");
    var batchid = pref.getString("Batch_id");


    const url = "https://masyseducare.com/masyseducarestudents.asmx/Classwork";
    final body = {
      "Head_Id":headid.toString(),
      "Subhead_Id":ID.toString(),
      "Std_Id":stdid,
      "Batch_Id":batchid
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      // ignore: deprecated_member_use
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = classworkFromJson(dataString);

      setState(() {
        classwork = jsonData;
      });
    }
  }

  void _toggleHomework() {
    setState(() {
      _showHomework = true;
      _showClasswork = false;
    });
  }

  void _toggleClasswork() {
    setState(() {
      _showClasswork = true;
      _showHomework = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        actions: const [],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: _toggleHomework,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: _showHomework ? Colors.blue : Colors.grey, width: 3.0), // Updated color based on selection
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  padding: const EdgeInsets.all(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.assignment),
                    Text("Homework"),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: _toggleClasswork,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: _showClasswork ? Colors.blue : Colors.grey, width: 3.0), // Updated color based on selection
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  padding: const EdgeInsets.all(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.assignment),
                    Text("Classwork"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),

          Expanded(
            child: homework.isEmpty && classwork.isEmpty
                ? const Center(
              child: CircularProgressIndicator(), // Display loading indicator
            )
                :_showHomework
                ? ListView.builder(
              itemCount: homework.length,
              itemBuilder: (context, index) {
                final home =homework[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    color:MyColorTheme.accentColor,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                home.subject,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            home.description,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Submission On: ${home.submissionDate} ",
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                          const Divider(color: Colors.blue),
                          Text(
                            "Uploaded By: ${home.uploadBy} (${home.dateIssued})",
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                : _showClasswork
                ? ListView.builder(
              itemCount: classwork.length,
              itemBuilder: (context, index) {
                final clas = classwork[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:  Card(
                    color: Colors.blue.shade200,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                clas.subject,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            clas.description,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Submission On: ${clas.submissionDate} ",
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                          const Divider(color: Colors.blue),
                          Text(
                            "Uploaded By: ${clas.uploadBy} (${clas.dateIssued})",
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                : const SizedBox(), // Empty space when no button is pressed
          ),
        ],
      ),
    );
  }
}

