import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text("Quick Links", style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey,width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var link in linkData)
                GestureDetector(
                  onTap: () {
                    _launchURL(link['url']);
                  },
                  child: Image.asset(
                    link['image'],
                    scale: 20,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> linkData = [
  {"image": "assets/image/instagram.png", "url": "https://www.instagram.com/"},
  {"image": "assets/image/twitter.png", "url": "https://twitter.com/"},
  {"image": "assets/image/youtube.png", "url": "https://www.youtube.com/"},
  {"image": "assets/image/facebook.png", "url": "https://www.facebook.com/"},
  {"image": "assets/Icon/address_logo.png", "url": ""},
];

void _launchURL(String url) async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
