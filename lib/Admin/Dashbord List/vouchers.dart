import 'package:flutter/material.dart';
import 'package:masys_educare/Admin/Admin%20Webservice/getvouchres.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class VoucherScreen extends StatefulWidget {
  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  List<Vouchers> vouchers = [];
  DateTime? selectedDate;
  int? userid;
  int? orgid;
  int? headid;
  String? role;
  String? fristname;
  String? lastname;


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
    fristname = preferences.getString("Firstname");
    lastname= preferences.getString("Lastname");
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
      "Type": "Voucher",
    };

    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        vouchers = vouchersFromJson(response.body);
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
              child: vouchers.isEmpty
                  ? Center(
                // Show an empty image when dashbordlist is empty
                child: Image.asset(
                    'assets/emptyimage.png'), // Replace 'assets/empty_image.png' with your image asset path
              )
                  : ListView.builder(
                itemCount: vouchers.length,
                itemBuilder: (BuildContext context, int index) {
                  final voucher = vouchers[index];
                  return ListTile(
                    title: Text(voucher.receiver),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${voucher.id}"),
                            Text("${voucher.amount}"),
                            Text("${voucher.particulars}"),

                          ],
                        ),
                        Text("${voucher.particulars}"),
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
          child: Image.asset('assets/gift-voucher.png'),
        ));
  }
  _launchURL() async {
    final url = 'https://masyseducare.com/App_Pages/Voucher_Entry.aspx?ID=$userid&UID=$orgid&HID=$headid&Role=$role&Name=$fristname%20$lastname';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
