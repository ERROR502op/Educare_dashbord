import 'package:flutter/material.dart';
import 'package:masys_educare/Webservice%20model/remarks_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:xml/xml.dart'as xml;


class RemarksScreen extends StatefulWidget {
  const RemarksScreen({super.key});

  @override
  State<RemarksScreen> createState() => _RemarksScreenState();
}

class _RemarksScreenState extends State<RemarksScreen> {

  List<RemarkData> remarksList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getremarks();
  }

  Future<void> getremarks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    var Id = pref.getInt("Id");
    const url = "https://masyseducare.com/masyseducarestudents.asmx/Remarks";
    final body = {
      "ID":Id.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);

      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = remarkDataFromJson(dataString);

      setState(() {
        remarksList = jsonData;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (remarksList.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.red.shade50,
        appBar: AppBar(
          title: const Text('Remarks'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.red.shade50,
        appBar: AppBar(
          title: const Text('Remarks'),
        ),
        body: ListView.builder(
          itemCount: remarksList.length,
          itemBuilder: (context, index) {
            final remark = remarksList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(4.0), // Add padding inside the ListTile
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          remark.remarks,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        Divider()
                      ],
                    ),
                    subtitle:Align(
                      alignment: Alignment.bottomRight,
                      child:  Text(
                        'By:${remark.uploadBy} '
                            ' (${remark.uploadedOn})',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    )
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}