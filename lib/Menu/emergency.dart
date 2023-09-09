import 'package:flutter/material.dart';
import 'package:masys_educare/Webservice%20model/getrcircular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';
import '../Model/mytheme.dart';

class Emergencyscreen extends StatefulWidget {
  const Emergencyscreen({Key? key}) : super(key: key);

  @override
  State<Emergencyscreen> createState() => _EmergencyscreenState();
}

class _EmergencyscreenState extends State<Emergencyscreen> {
  List<Getcircular> circular = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcircular();
  }

  Future<void> getcircular() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headid = pref.getInt("Head_Id");
    var studentid = pref.getString("StudentId");
    var stdid = pref.getString("Std_id");
    var batchid = pref.getString("Batch_id");

    const url =
        "https://masyseducare.com/masyseducarestudents.asmx/GetCircular";
    final body = {
      "Type": "Student",
      "Head_Id": headid.toString(),
      "Subhead_Id": studentid,
      "Std_Id": stdid,
      "Batch_Id": batchid
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      // ignore: deprecated_member_use
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = getcircularFromJson(dataString);

      setState(() {
        circular = jsonData;
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
          title: const Text('Emergency Circular'),
        ),
        body: circular.isEmpty
            ? const Center(
                child:
                    CircularProgressIndicator(), // Show CircularProgressIndicator if data is being fetched
              )
            : ListView.builder(
                itemCount: circular.length,
                itemBuilder: (context, index) {
                  // Calculate the desired container height based on screen height

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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Card(
                                    color: MyColorTheme.primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        circular[index].title,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    height: 50,
                                    child: Image.asset("assets/Icon/mic.png"))
                              ],
                            ),
                            Text(
                              circular[index].desc,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Uploaded on: ${circular[index].dateUploaded}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.grey, thickness: 0.5),
                            Text(
                              "Uploaded By: ${circular[index].uploadBy}",
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
              ));
  }
}
