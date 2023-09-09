import 'package:flutter/material.dart';
import 'package:masys_educare/Admin/Whatsapp/studentwithbatchid.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Admin Webservice/batcheswebservice.dart';

class BatcheScreen extends StatefulWidget {
  const BatcheScreen({Key? key}) : super(key: key);

  @override
  State<BatcheScreen> createState() => _BatcheScreenState();
}

class _BatcheScreenState extends State<BatcheScreen> {
  List<Batches> batches = [];
  List<Batches> filteredBatches = []; // Store filtered batches
  late FloatingSearchBarController controller; // Create a search bar controller

  @override
  void initState() {
    super.initState();
    getbatches();
    controller = FloatingSearchBarController(); // Initialize the controller
    controller.open();
  }

  Future<void> getbatches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ID = prefs.getInt("B_Code");
    const url =
        "https://masyseducare.com/masyseducareadmin.asmx/GetBatchWithStudentCount";
    final body = {
      "B_Code": ID.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        batches = batchesFromJson(response.body);
        filteredBatches =
            batches; // Initialize filtered batches with all batches
      });
    }
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        // Assign the controller to the search bar
        hint: 'Search for a batch...',
        scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: Duration(milliseconds: 400),
        transitionCurve: Curves.easeInOut,
        physics: BouncingScrollPhysics(),
        axisAlignment: 0.0,
        openAxisAlignment: 0.0,
        width: 600,
        debounceDelay: Duration(milliseconds: 500),
        onQueryChanged: (query) {
          // Filter batches based on search input
          setState(() {
            filteredBatches = batches.where((batch) {
              return batch.headName
                  .toLowerCase()
                  .contains(query.toLowerCase());
            }).toList();
          });
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: filteredBatches.map((batch) {
                  return ListTile(
                    title: Text(batch.headName),
                    onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentWithBatchID(batchId: batch.batchId,)));
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
