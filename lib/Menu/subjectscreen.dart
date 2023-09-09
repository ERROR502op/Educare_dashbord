import 'package:flutter/material.dart';
import 'package:masys_educare/Menu/notes.dart';
import 'package:masys_educare/Webservice%20model/getsubject.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class Subjectscreen extends StatefulWidget {
  const Subjectscreen({Key? key}) : super(key: key);

  @override
  State<Subjectscreen> createState() => _SubjectscreenState();
}

class _SubjectscreenState extends State<Subjectscreen> {
  List<Getsubject> subjects = []; // List to hold fetched subjects

  void initState() {
    super.initState();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var ID = pref.getInt("Id");
    var batchId = pref.getString("Batch_id");

    const url =
        "https://masyseducare.com/masyseducarestudents.asmx/GetNotesSubject";
    final body = {
      "Student_Id": ID.toString(),
      "Batch_Id": batchId
    };

    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(()  {
        subjects = getsubjectFromJson(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: Text('Subjects'),
      ),
      body: subjects.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching
          : ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return InkWell(
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString("notesid", subject.subId);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Notesscreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.10,
                              child: Image.asset("assets/folder.png"),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  subject.subName,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
