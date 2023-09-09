import 'package:flutter/material.dart';
import 'package:masys_educare/Admin/Admin%20Webservice/staffattendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class StaffAttendance extends StatefulWidget {
  const StaffAttendance({super.key});

  @override
  State<StaffAttendance> createState() => _StaffAttendanceState();
}

class _StaffAttendanceState extends State<StaffAttendance> {
  List<Staffattendance> staffattendance = [];
  String selectedMonth = ''; // Default selected month
  int selectedYear = 0; // Default selected year

  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = DateFormat('MMMM').format(now);
    selectedYear = now.year;
    getstaffattendance();
  }

  Future<void> getstaffattendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ID = prefs.getInt("StaffId");
    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/GetFacultyBiometric";
    final body = {
      "User_Id": ID.toString(),
      "month": getMonthNumber(selectedMonth).toString(),
      "year": selectedYear.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        staffattendance = staffattendanceFromJson(response.body);
      });
    }
  }

  Map<String, int> monthToNumber = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12,
  };
  int getMonthNumber(String monthName) {
    return monthToNumber[monthName] ?? 1; // Default to January if not found
  }

  void reload() {
    setState(() {
      getstaffattendance();
    });
  }

  List<int> years = [2022, 2023, 2024]; // Customize the years as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<int>(
                value: getMonthNumber(selectedMonth),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedMonth = monthToNumber.entries
                        .firstWhere((entry) => entry.value == newValue)
                        .key;
                    reload();
                  });
                },
                items:
                    monthToNumber.entries.map<DropdownMenuItem<int>>((entry) {
                  return DropdownMenuItem<int>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
              ),
              DropdownButton<int>(
                value: selectedYear,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                    reload();
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
            child: staffattendance.isEmpty
                ? Center(child: Image.asset("assets/emptyimage.png"))
                : ListView.builder(
                    itemCount: staffattendance.length,
                    itemBuilder: (BuildContext context, int index) {
                      final staff = staffattendance[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            '${staff.name}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(staff.dateConvert),
                              Text(staff.timeLog),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
