import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Attendanceadmin extends StatefulWidget {
  const Attendanceadmin({super.key});

  @override
  State<Attendanceadmin> createState() => _AttendanceadminState();
}

class _AttendanceadminState extends State<Attendanceadmin> {
  // Sample data for attendance
  List<String> attendanceData = [
    'Matin sir - Present',
    'Kailas Dada - Absent',
    'Biometric Web service Remaing',
    // Add more entries as needed
  ];



  Future<void> getStudentInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ID = prefs.getInt("ContactID");
    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/GetStudentBiometric";
    final body = {
      "ID": ID.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {

      });
    }
  }

  String selectedMonth = 'January'; // Default selected month
  int selectedYear = 2023; // Default selected year

  // List of months and years for dropdowns
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  List<int> years = [2022, 2023, 2024]; // Customize the years as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                value: selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                },
                items: months.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<int>(
                value: selectedYear,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
                items: years.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attendanceData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(attendanceData[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

