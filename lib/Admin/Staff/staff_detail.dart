import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Model/mytheme.dart';
import '../Admin Webservice/staffdeatils.dart';
import 'package:http/http.dart' as http;

class StaffDetail extends StatefulWidget {
  final String? ContactID;

  const StaffDetail({super.key, this.ContactID});

  @override
  State<StaffDetail> createState() => _StaffDetailState();
}

class _StaffDetailState extends State<StaffDetail> {
  List<Staffdeatils> studentInfo = [];

  @override
  void initState() {
    super.initState();
    getStudentInfo();
  }

  Future<void> getStudentInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ID = prefs.getInt("StaffId");
    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/GetFacultyDetails";
    final body = {
      "ID": ID.toString(),
    };

    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        studentInfo = staffdeatilsFromJson(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: studentInfo.length,
        itemBuilder: (BuildContext context, int index) {
          final student = studentInfo[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  "Basic Information",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColorTheme.primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  elevation: 0,
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Full Name :'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Gender: '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Qualification :'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Designation: '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Shift 1: '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Staff: '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Week Off:'),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${student.firstName} ${student.lastName}' ?? 'NA'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${student.gender}' ?? 'NA'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${student.qualification }'?? 'NA'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${student.designation}' ?? 'NA'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Text('${student.mfInTime} TO ${student.mfOutTime}' ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Text('${student.payType} /${student.facultyType}'?? 'NA'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Text('${student.weekOff}'?? 'NA'),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        elevation: 0,
                        color: Colors.grey.shade200,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                          ),
                          title: Text(
                            "${student.firstName ?? 'NA'}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("${student.mobileForSms ?? 'NA'}"),
                          trailing: IconButton(
                            onPressed: () async {
                              launch('tel://${student.mobileForSms}');
                            },
                            icon: Icon(Icons.phone),
                          ),
                        )),

                    if (student.address != null && student.address.isNotEmpty)
                      Card(
                        elevation: 0,
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Address: ${student.address}"),
                        ),
                      ),


                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
