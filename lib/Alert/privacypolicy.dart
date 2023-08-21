
import 'package:flutter/material.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Privacy Policy'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('It is important that you understand what information app collects and uses.'),
            Text('App uses collected information for the following general purposes: products and services provision, billing, identification and authentication, services improvement, contact, and research.'),
            Text("Name to establish the identity of users and maintain their accounts."),
            Text("App uses Phone number for login purposes and to show them on the profile or to contact you."),
            Text("We collect User images in some cases as mandated to show them on the profile. We do not collect video files."),
            Text("PDFs - We collect user file in PDF format. We do not collect any other files."),
            Text("Important: Please be assured that the app does not collect or share any of your personal or sensitive data."),
            // Add more Text widgets to display your privacy policy content
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('I Agree'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: const Text('Decline'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}

