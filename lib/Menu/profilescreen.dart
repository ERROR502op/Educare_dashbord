import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profile_image.jpg'), // Replace with your image asset
            ),
            SizedBox(height: 20),
            Text(
              'John Doe', // Replace with student's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Class: 10', // Replace with student's standard
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            // Additional Profile Information
            _buildProfileInfo("Email", "john.doe@example.com"), // Replace with actual data
            SizedBox(height: 10),
            _buildProfileInfo("Phone", "+1 (123) 456-7890"), // Replace with actual data
            SizedBox(height: 20),
            // Add other profile information or actions here
            ElevatedButton(
              onPressed: () {
                // Add action here
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label + ": ",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}