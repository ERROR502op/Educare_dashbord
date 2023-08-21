import 'package:flutter/material.dart';
import 'package:masys_educare/Screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/mytheme.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});


  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  bool isLoading = false;
  String? studentname;

  // ignore: non_constant_identifier_names
  String? Id;
  String? batchname;
  String? stdname;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reloadData();
  }
  Future<void> reloadData() async {
    setState(() {
      isLoading = true; // Show loading indicator while reloading data
    });

    await _loadstudentData();

    setState(() {
      isLoading = false; // Hide loading indicator
    });
  }
  Future<void> _loadstudentData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    studentname= preferences.getString("FullName");
    Id= preferences.getString("StudentId");
    stdname= preferences.getString("StdName");
    batchname= preferences.getString("Batch_Name");

  }
  void logout(BuildContext context) async {

    bool confirmLogout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User doesn't confirm logout
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirms logout
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove("log");

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
            ),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/000/618/556/original/education-logo-vector-template.jpg'),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$studentname',
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text('ID $Id'),
                          Text('Class: $stdname'),
                          Text('Batch: $batchname'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Implement what happens when the user taps on Home
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Implement what happens when the user taps on Settings
              Navigator.pop(context); // Close the drawer
            },
          ),

          ElevatedButton(
            onPressed: isLoading
                ? null
                : () {

                logout(context);

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColorTheme.primaryColor,
            ),
            child: isLoading
                ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(MyColorTheme.primaryColor),
            )
                : const Text(
              'LOG OUT',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Add more ListTiles for other drawer options
        ],
      ),
    );
  }
}
