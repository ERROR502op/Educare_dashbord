import 'package:flutter/material.dart';
import 'package:masys_educare/Model/mytheme.dart';
import 'package:masys_educare/Webservice%20model/notice_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';

class NoticeBoradScreen extends StatefulWidget {
  const NoticeBoradScreen({Key? key}) : super(key: key);

  @override
  State<NoticeBoradScreen> createState() => _NoticeBoradScreenState();
}

class _NoticeBoradScreenState extends State<NoticeBoradScreen> {
  List<Notice> notices = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnotice();
  }

  Future<void> getnotice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headid = pref.getInt("Head_Id");
    var subneadid = pref.getString("SuBhead_id");
    var stdid = pref.getString("Std_id");
    var batchid = pref.getString("Batch_id");

    const url = "https://masyseducare.com/masyseducarestudents.asmx/NoticeNew";
    final body = {
      "Head_Id": headid.toString(),
      "Subhead_Id": subneadid,
      "Std_Id": stdid,
      "Batch_Id": batchid
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      // ignore: deprecated_member_use
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = noticeFromJson(dataString);

      setState(() {
        notices = jsonData;
      });
    }
  }

  String formatDate(String inputDate) {
    final originalFormat = DateFormat('dd/MM/yyyy');
    final newFormat = DateFormat(
        'dd MMM', 'en_US'); // 'en_US' locale for English month abbreviation
    final date = originalFormat.parse(inputDate);
    final formattedDate = newFormat.format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Notice Board'),
      ),
      body: notices.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator(), // Show CircularProgressIndicator if data is being fetched
            )
          : ListView.builder(
              itemCount: notices.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Card(
                                color: MyColorTheme.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        formatDate(notices[index].date),
                                        // Use the formatted date here
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  notices[index].title,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            notices[index].desc,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          Text(
                            "Uploaded By: ${notices[index].uploadBy}",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
