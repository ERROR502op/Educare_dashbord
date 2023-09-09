import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Webservice model/getimage.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  List<Getimage> images = [];
  List<String> imagePaths = [];
  int selectedImageIndex = 0; // Index of the selected image for slide view

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  Future<void> _getImages() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headid = pref.getInt("Head_Id");
    var Id = pref.getInt("Id");
    var stdid = pref.getString("Std_id");
    var batchid = pref.getString("Batch_id");

    const url = "https://masyseducare.com/masyseducarestudents.asmx/GetSharedImage";
    final body = {
      "Type": "Student",
      "Head_Id": headid.toString(),
      "Subhead_Id": Id.toString(),
      "Std_Id": stdid,
      "Batch_Id": batchid,
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      final dataString = xmlDoc.findAllElements('string').first.text;
      final jsonData = getimageFromJson(dataString);

      setState(() {
        images = jsonData;
        imagePaths = images.map((image) => "http://classassist.masysgroup.com/Clickshare/${image.imagename}").toList(); // Extract paths from Getimage objects
      });
    }
  }

  void openImageSlideView(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageSlideView(imagePaths: imagePaths, initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
      ),
      body:GridView.builder(
        itemCount: images.length > 0 ? images.length : 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          if (images.isEmpty) {
            // Display loading bar when imagePaths is empty
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GestureDetector(
              onTap: () {
                openImageSlideView(index); // Open slide view on tap
              },
              child: Image.network(imagePaths[index],fit: BoxFit.fitHeight,),
            );
          }
        },
      ),


    );
  }

  void pickImages() {
    // Implement your image picking logic here
  }
}

class ImageSlideView extends StatelessWidget {
  final List<String> imagePaths;
  final int initialIndex;

  const ImageSlideView({required this.imagePaths, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Gallery"),
      ),
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Expanded(
                child: PhotoViewGallery.builder(
                  itemCount: imagePaths.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(imagePaths[index]),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  pageController: PageController(initialPage: initialIndex),
                ),
              ),
            ],
          ),
    );
  }
}
