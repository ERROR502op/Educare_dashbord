import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Webservice model/classwork.dart';
import '../Webservice model/homework.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';

class AssignmentScreenState extends StatefulWidget {
  @override
  _AssignmentScreenStateState createState() => _AssignmentScreenStateState();
}

class _AssignmentScreenStateState extends State<AssignmentScreenState>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Homework> homework = [];
  List<Classwork> classwork = [];

  @override
  void initState() {
    super.initState();
    _homework();
    _classwork();
    _tabController = TabController(length: 2, vsync: this);
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
      "Head_Id": headid.toString(),
      "Subhead_Id": ID.toString(),
      "Std_Id": stdid,
      "Batch_Id": batchid
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
    var ID = pref.getInt("Id");
    var stdid = pref.getString("Std_id");
    var batchid = pref.getString("Batch_id");

    const url = "https://masyseducare.com/masyseducarestudents.asmx/Classwork";
    final body = {
      "Head_Id": headid.toString(),
      "Subhead_Id": ID.toString(),
      "Std_Id": stdid,
      "Batch_Id": batchid
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

  void _openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Select Subject",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildSubjectList(setState), // Build the list of subjects
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Implement your filter logic here
                      // You can access selected subjects from the state
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: const Text("Apply Filters"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSubjectList(StateSetter setState) {
    // Replace this with your actual list of subjects
    List<String> subjects = ["Math", "Science", "History", "English", "Art"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: subjects.map((subject) {
        bool isSelected = false; // Initialize with false
        return Row(
          children: [
            Expanded(child: Text(subject)),
            IconButton(
              icon:
                  // ignore: dead_code
                  Icon(isSelected ? Icons.check_circle : Icons.circle_outlined),
              onPressed: () {
                setState(() {
                  isSelected = !isSelected; // Toggle selection
                });
              },
            ),
          ],
        );
      }).toList(),
    );
  }

  String formatDate(String inputDate) {
    final originalFormat = DateFormat('dd/MM/yyyy');
    final newFormat = DateFormat(
        'MMM yyyy', 'en_US'); // 'en_US' locale for English month abbreviation

    final date = originalFormat.parse(inputDate);
    final formattedDate = newFormat.format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.red.shade50,
      appBar: AppBar(
        title: const Text("Assignments"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _openFilterBottomSheet(); // Function to open the bottom sheet
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(
              text: "Homework",
            ),
            const Tab(text: "Classwork"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildListViewhome(), _buildListViewclass()],
      ),
    );
  }

  Widget _buildListViewhome() {
    return homework.isEmpty
        ? const Center(
            child: CircularProgressIndicator(), // Display loading indicator
          )
        : ListView.builder(
            itemCount: homework.length,
            itemBuilder: (context, index) {
              final home = homework[index];
              return Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(formatDate(home.dateIssued)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "Home Work - ${home.subject}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            home.description,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Visibility(
                          visible: home.submissionDate != null,
                          child: Text(
                            "🗓️ : ${home.submissionDate} ",
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                        ),
                        const SizedBox(height: 10,),

                        Text(
                          "By: ${home.uploadBy} (${home.dateIssued})",
                          style: const TextStyle(fontSize: 12),
                        ),

                      ],
                    ),
                  ),

                ],
              );
            },
          );
  }

  Widget _buildListViewclass() {
    return classwork.isEmpty
        ? const Center(
            child: CircularProgressIndicator(), // Display loading indicator
          )
        : ListView.builder(
            itemCount: classwork.length,
            itemBuilder: (context, index) {
              final Class = classwork[index];
              return Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(formatDate(Class.dateIssued)),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "Class Work - ${Class.subject}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            Class.description,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Visibility(
                          visible: Class.submissionDate != null,
                          child: Text(
                            "🗓️ : ${Class.submissionDate} ",
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                        ),
                        const SizedBox(height: 10,),

                        Text(
                          "By: ${Class.uploadBy} (${Class.dateIssued})",
                          style: const TextStyle(fontSize: 12),
                        ),

                      ],
                    ),
                  ),

                ],
              );
            },
          );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
