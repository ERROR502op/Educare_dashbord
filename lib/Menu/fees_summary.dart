import 'package:flutter/material.dart';
import 'package:masys_educare/Webservice%20model/fees_total.dart';
import 'package:masys_educare/Webservice%20model/feesdata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class FeeSummaryScreen extends StatefulWidget {
  const FeeSummaryScreen({super.key});

  @override
  State<FeeSummaryScreen> createState() => _FeeSummaryScreenState();
}

class _FeeSummaryScreenState extends State<FeeSummaryScreen> {

  List<FeeData> feeData = [];
  List<FeesSummary> feetotal = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfeeslogs();
    feessummary();
  }

  Future<void> getfeeslogs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    var Id = pref.getInt("Id");

    const url = "https://masyseducare.com/masyseducarestudents.asmx/FeesLog";
    final body = {
      "ID":Id.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      // ignore: deprecated_member_use
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = feeDataFromJson(dataString);

      setState(() {
        feeData = jsonData;
      });
    }
  }
  Future<void> feessummary() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    var Id = pref.getInt("Id");

    const url = "https://masyseducare.com/masyseducarestudents.asmx/FeesSummary";
    final body = {
      "ID":Id.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      // ignore: deprecated_member_use
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = feesSummaryFromJson(dataString);

      setState(() {
        feetotal = jsonData;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fee Summary'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Table(
                border: TableBorder.symmetric(
                  inside: const BorderSide(width: 1, color: Colors.purple),
                  outside: const BorderSide(width: 1, color: Colors.white),
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  const TableRow(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    children: [
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fees',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Paid',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Balance',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  for (var datatotal in feetotal)
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: Text('Tuition')),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              "${datatotal.finalTFees}",
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              "${datatotal.tPaid}",
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              "${datatotal.tBal}",
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: feeData.isEmpty ? 1 : feeData.length,
                itemBuilder: (BuildContext context, int index) {
                  // ignore: prefer_is_empty
                  if (feeData.length == 0) {
                    // Show a circular progress indicator if the list is empty
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var currentItem = feeData[index];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text('Fee Item ${index + 1}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${currentItem.paymentDate}'),
                          const SizedBox(height: 4),
                          Text('Receipt No.: ${currentItem.receiptNo}'),
                          const SizedBox(height: 4),
                          Text('Course Fee: ${currentItem.amtRecieved}'),
                          const SizedBox(height: 4),
                          Text('Status: ${currentItem.status}'),
                        ],
                      ),
                    ),
                  );
                },
              ),


            ],
          )
        ),
      ),
    );
  }
}


