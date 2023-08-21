import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:masys_educare/Webservice%20model/suggestion.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../Model/mytheme.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String responseData = '';
  bool isLoading = false;
  List<GetSuggestion> getsuggestion = [];

  @override
  void initState() {
    super.initState();
    _getsuggestion();
  }

  Future<void> _suggestion() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    var Id = pref.getInt("Id");

    try {
      const url =
          "https://masyseducare.com/masyseducarestudents.asmx/Suggestion";
      final body = {
        "ID": Id.toString(),
        "Subject": _subjectController.text,
        "Suggestion": _descriptionController.text,
      };
      final response = await http.post(Uri.parse(url), body: body);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final xmlDocument = xml.XmlDocument.parse(responseBody);
        final xmlText = xmlDocument.findAllElements('string').first.text;

        setState(() {
          responseData = xmlText;
          setState(() {
            isLoading = false; // Set isLoading to false here
          });
        });

        if (responseData == "\"Success\"") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: SizedBox(
                    height: 100,
                    child: Lottie.asset("assets/Lottie/Successfully.json")),
                content: const Text(
                  'Suggestion Added Success !',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Future.delayed(const Duration(seconds: 2), () {
                        // Move this part outside of setState()
                        setState(() {
                          isLoading = false;
                        });
                      });
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      _subjectController.clear();
                      _descriptionController.clear();
                      _getsuggestion();

                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (error) {}
  }

  Future<void> _getsuggestion() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var Id = pref.getInt("Id");

    const url =
        "https://masyseducare.com/masyseducarestudents.asmx/GetSuggestion";
    final body = {
      "UID": Id.toString(),
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      setState(() {
        getsuggestion = getSuggestionFromJson(response.body);
      });
    }
  }

  void _showSuggestionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            margin: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'Share Your Suggestion',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade900),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a subject';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState?.validate() == true) {
                                  _suggestion();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColorTheme.primaryColor,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    MyColorTheme.primaryColor),
                              )
                            : const Text(
                                'SUBMIT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Suggestion'),
      ),
      body:getsuggestion.isEmpty
          ? const Center(
        child: CircularProgressIndicator(), // Display loading indicator
      )
          : ListView.builder(
        itemCount: getsuggestion.length,
        // Replace suggestionList with your actual list of suggestions
        itemBuilder: (context, index) {
          final suggestion = getsuggestion[
              index]; // Replace suggestionList with your actual list of suggestions
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                    contentPadding: const EdgeInsets.all(4.0),
                    // Add padding inside the ListTile
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text("${suggestion.title}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Text("🚀",
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        Text(
                          "${suggestion.description}",
                        ),
                        Divider()
                      ],
                    ),
                    subtitle: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'By: ${suggestion.name}',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    )),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSuggestionBottomSheet();
        },
        child: const Icon(Icons.open_in_new,size: 30,),
      ),
    );
  }
}
