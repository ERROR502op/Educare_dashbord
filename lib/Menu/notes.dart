import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart'; // Import the flutter_downloader package
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;
import '../Webservice model/notesdata.dart';
import 'dart:io';

class Notesscreen extends StatefulWidget {
  const Notesscreen({super.key});

  @override
  State<Notesscreen> createState() => _NotesscreenState();
}

class _NotesscreenState extends State<Notesscreen> {
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  List<NotesData> notes = [];

  Future<void> fetchNotes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headId = pref.getInt("Head_Id");
    var ID = pref.getInt("Id");
    var stdId = pref.getString("Std_id");
    var batchId = pref.getString("Batch_id");

    const url = "https://masyseducare.com/masyseducarestudents.asmx/Notes";
    final body = {
      "Head_Id": headId.toString(),
      "Subhead_Id": ID.toString(),
      "Std_Id": stdId,
      "Batch_Id": batchId,
    };
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = notesDataFromJson(dataString);

      setState(() {
        notes = jsonData;
      });
    }
  }

  Future<void> downloadFileWithAlert(
      BuildContext context, String url, String fileName) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final appDir = await getExternalStorageDirectory();
      final savePath = "${appDir?.path}/$fileName";

      final file = File(savePath);

      if (await file.exists()) {
        // File already exists, show a dialog with only the "Open" button
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('File Already Downloaded'),
              content: const Text('Do you want to open the downloaded file?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFView(
                          filePath: savePath,
                        ),
                      ),
                    );
                  },
                  child: const Text('Open'),
                ),
              ],
            );
          },
        );
      } else {
        // File does not exist, initiate the download
        final taskId = await FlutterDownloader.enqueue(
          url: url,
          savedDir: appDir!.path,
          fileName: fileName,
          showNotification: true,
          openFileFromNotification: true,
          headers: {}, // Remove headers for resuming
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Download Complete'),
              content:
                  const Text('File downloaded successfully. Do you want to open it?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();

                    // Check if the file exists before attempting to open it
                    if (await file.exists()) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFView(
                            // Make sure you have the correct widget here
                            filePath: savePath,
                          ),
                        ),
                      );
                    } else {
                      // File not downloaded successfully
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('File download failed. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Open'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission denied'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Notes Screen'),
      ),
      body: notes.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Download File'),
                            content: const Text('Do you want to download this file?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  final downloadUrl =
                                      "https://masyseducare.com/Notes/${note.filepath}";
                                  final fileName = note.filepath;
                                  downloadFileWithAlert(
                                      context, downloadUrl, fileName);
                                },
                                child: const Text('Download'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.10,
                              child: Image.asset("assets/folder.png"),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  note.subName,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(note.title),
                                trailing: const Icon(
                                  Icons.download_for_offline,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
