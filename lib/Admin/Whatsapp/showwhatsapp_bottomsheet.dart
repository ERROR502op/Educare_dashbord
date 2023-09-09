import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

void ShowWhatsAppBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Send WhatsApp Message',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, size: 24),
                  onPressed: () {
                    _showAttachmentOptions(context);
                  },
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement sending message logic here
              },
              child: Text('Send'),
            ),
          ],
        ),
      );
    },
  );
}

void _showAttachmentOptions(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text('Attach File'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              _pickImageFromCamera(context);
            },
            child: Row(
              children: [
                Icon(Icons.add_photo_alternate),
                SizedBox(width: 8),
                Text('Add Photo'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              _pickImageFromGallery(context);
            },
            child: Row(
              children: [
                Icon(Icons.insert_drive_file),
                SizedBox(width: 8),
                Text('Select From Gallery'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              _pickDocument(context);
            },
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text('Add Documents'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Cancel'),
              ],
            ),
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
