import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:masys_educare/Screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Corrected the constructor syntax
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Masys Educare',
      theme: ThemeData(
        primaryColor: Colors.blue.shade900, // Set the primary color to deep purple
        fontFamily: 'BricolageGrotesque', // Set your desired font family
        // Set the color scheme
        useMaterial3: true,
      ),
      home: const SplashScreen()
    );
  }
}
