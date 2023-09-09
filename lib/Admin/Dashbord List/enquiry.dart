import 'package:flutter/material.dart';
import 'package:masys_educare/Admin/Admin%20Webservice/enquiry.dart';
import 'package:masys_educare/Admin/Admin%20Webservice/getdashboradlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EnquiryScreen extends StatefulWidget {
  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  List<Enquiry> enquiry = [];
  DateTime? selectedDate;
  int? userid;
  int? orgid;
  int? headid;
  String? role;


  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();

    // Simulate a 2-second loading delay
    Future.delayed(Duration(seconds: 2), () {
      getstaffattendance(selectedDate!);
    });
    getsharedvalue();
  }

  void getsharedvalue()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    userid = preferences.getInt("User_ID");
    orgid = preferences.getInt("Org_ID");
    headid = preferences.getInt("B_Code");
    role = preferences.getString("role");
  }

  Future<void> getstaffattendance(DateTime dateToPass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ID = prefs.getInt("B_Code");

    // Format the date as "dd-MM-yyyy"
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateToPass);

    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/GetDashboardList";
    final body = {
      "headid": ID.toString(),
      "date": formattedDate,
      "Type": "Enquiry",
    };

    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        enquiry = enquiryFromJson(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Addmission'),
        ),
        body: Column(
          children: [
            Container(
              height: 150,
              child: SfCalendar(
                view: CalendarView.month,
                monthViewSettings: MonthViewSettings(
                  numberOfWeeksInView: 1,
                ),
                onSelectionChanged: (dateDetails) {
                  setState(() {
                    selectedDate = dateDetails.date;
                  });
                  getstaffattendance(
                      selectedDate!); // Fetch data for the selected date
                },
              ),
            ),
            Expanded(
              child: enquiry.isEmpty
                  ? Center(
                // Show an empty image when dashbordlist is empty
                child: Image.asset(
                    'assets/emptyimage.png'), // Replace 'assets/empty_image.png' with your image asset path
              )
                  : ListView.builder(
                itemCount: enquiry.length,
                itemBuilder: (BuildContext context, int index) {
                  final dashborad = enquiry[index];
                  return ListTile(
                    title: Text(dashborad.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dashborad.status),
                        Text(dashborad.lastFollowup),
                        Text(dashborad.nextFollowup),

                        Text(dashborad.latestRemarks),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _launchURL();
          },
          child: Image.asset('assets/question.png'),
        ));
  }
  _launchURL() async {
    final url = 'https://masyseducare.com/App_Pages/Enquiry.aspx?ID=$userid&UID=$orgid&HID=$headid&Role=$role';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
