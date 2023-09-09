import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:masys_educare/Admin/Admin%20Webservice/admin_get_notice.dart';
import 'package:masys_educare/Admin/Admin%20Webservice/getbatch.dart';
import 'package:masys_educare/Admin/Admin%20Webservice/getstd.dart';
import 'package:masys_educare/Model/mytheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '_showattachedment.dart';

class AdminNotice extends StatefulWidget {
  const AdminNotice({Key? key}) : super(key: key);

  @override
  State<AdminNotice> createState() => _AdminNoticeState();
}

class _AdminNoticeState extends State<AdminNotice> {
  String? selectedStd; // To store the selected standard
  String? selectedBranch; // To store the selected branch
  List<AdminGetNotice> notices = [];
  List<Getstd> std = [];
  List<Getbatch> batch = [];
  TextEditingController _stdcontroller = TextEditingController();
  TextEditingController _batchController = TextEditingController();
  String? selectStd;

  // Define a variable to track whether a standard has been selected.
  bool isStandardSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnotice();
    getStd();
  }

  Future<void> getnotice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var B_Code = pref.getInt("B_Code");

    const url = "https://masyseducare.com/masyseducareadmin.asmx/GetNotice";
    final body = {"B_Code": B_Code.toString(), "Std_Id": "", "Batch_Id": ""};
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      setState(() {
        notices = adminGetNoticeFromJson(response.body);
      });
    }
  }

  Future<void> getStd() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var B_Code = pref.getInt("B_Code");

    const url = "https://masyseducare.com/masyseducareadmin.asmx/GetStdNew";
    final body = {"B_Code": B_Code.toString()};
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        std = getstdFromJson(response.body);
      });
    }
  }

  Future<void> getbatch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var B_Code = pref.getInt("B_Code");
    var std_id = pref.getInt("Standart_id");

    const url = "https://masyseducare.com/masyseducareadmin.asmx/GetBatchNew";
    final body = {"Std_Id": std_id.toString(), "B_Code": B_Code.toString()};

    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      setState(() {
        batch = getbatchFromJson(response.body);
      });
    }
    Navigator.pop(context);
    addNoticeForAdmin(context);
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Notice Board'),
      ),
      body: notices.isEmpty
          ? Center(child: Image.asset("assets/emptyimage.png"))
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
                                        formatDate(notices[index].dateConvert),
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
                            notices[index].description,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          Text(
                            "Uploaded By: ${notices[index].uploadedByName}",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNoticeForAdmin(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addNoticeForAdmin(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Notice'),
          content: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TypeAheadFormField<Getstd>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _stdcontroller,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        hintText: 'Select Standard',
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return std
                          .where((item) => item.stdName
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, Getstd suggestion) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              suggestion.stdName,
                            ),
                          ],
                        ),
                      );
                    },
                    onSuggestionSelected: (Getstd suggestion)  {
                      setState(() async{
                        _stdcontroller.text = suggestion.stdName;
                        selectedStd = suggestion.stdName;

                        isStandardSelected = true;
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setInt("Standart_id", suggestion.stdId);
                        getbatch();
                      });

                    },
                    validator: (value) {
                      if (!isStandardSelected) {
                        return 'Please select a standard first';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:16,),
                  Visibility(
                    visible: isStandardSelected,
                    // Show this widget only if a standard is selected.
                    child: TypeAheadFormField<Getbatch>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _batchController,
                        // Use a different controller for batch.
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          hintText: 'Select Batch',
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return batch
                            .where((item) => item.batchName
                                .toLowerCase()
                                .contains(pattern.toLowerCase()))
                            .toList();
                      },
                      itemBuilder: (context, Getbatch suggestion) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                suggestion.batchName,
                              ),
                            ],
                          ),
                        );
                      },
                      onSuggestionSelected: (Getbatch suggestion) {
                        setState(() {
                          _batchController.text = suggestion.batchName;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a batch';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Discription'),
                  ),
                  TextButton(
                    onPressed: () {
                      showAttachmentOptions(context);
                    },
                    child: Text("Choose File"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle save button press here
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
