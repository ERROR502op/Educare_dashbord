import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import '../Webservice model/getbannerimg.dart';

class ImageSliderWithDots extends StatefulWidget {
  const ImageSliderWithDots({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageSliderWithDotsState createState() => _ImageSliderWithDotsState();
}

class _ImageSliderWithDotsState extends State<ImageSliderWithDots> {
  List<GetBannerImg> images = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  void fetchImages() async {
    try {
      const url =
          "https://masyseducare.com/masyseducareadmin.asmx/GetBannerDetails";
      final body = {};

      final response = await http.post(Uri.parse(url), body: body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<GetBannerImg> bannerImages = List<GetBannerImg>.from(
            jsonData.map((item) => GetBannerImg.fromJson(item)));

        setState(() {
          images = bannerImages;
        });
      }
      // ignore: empty_catches
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            onPageChanged: (index, _) {
              setState(() {
                _currentIndex = index;
              });
            },
            viewportFraction: 1.0,
          ),
          items: images.isEmpty // Check if images are empty
              ? [
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ]
              : images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0), // Add border radius
                        ),
                        child: SizedBox(
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              "https://masyseducare.com/ImageUpload/${image.image}",
                              fit: BoxFit.fitWidth, // Use a fit mode that works well for your layout
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map((image) {
              int index = images.indexOf(image);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Colors.purple.shade900
                      : Colors.blue.shade50,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
