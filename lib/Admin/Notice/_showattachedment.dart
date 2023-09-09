import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void showAttachmentOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              'Attach File',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            tileColor: Colors.grey[300],
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
          ListTile(
            leading: Icon(Icons.add_photo_alternate),
            title: Text('Add Photo'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
              _pickImageFromCamera(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.insert_drive_file),
            title: Text('Select From Gallery'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
              _pickImageFromGallery(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Add Documents'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
              _pickDocument(context);
            },
          ),
          ListTile(
            title: Text('Cancel'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
        ],
      );
    },
  );
}


void _pickImageFromCamera(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    // Handle the picked image (you can save, display, or send it)
    // You can access the image file using pickedFile.path
  }
}

void _pickImageFromGallery(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    // Handle the picked image (you can save, display, or send it)
    // You can access the image file using pickedFile.path
  }
}

void _pickDocument(BuildContext context) async {
  final result = await FilePicker.platform.pickFiles();
  if (result != null) {
    // Handle the picked document (you can save, display, or send it)
    // You can access the document file using result.files.single.path
  }
}
