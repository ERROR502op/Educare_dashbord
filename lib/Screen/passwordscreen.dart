import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:masys_educare/Model/mytheme.dart';
import 'package:masys_educare/Admin/adminpanel.dart';
import 'package:masys_educare/Screen/getstudent.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:xml/xml.dart' as xml;

class Passwordscreen extends StatefulWidget {
  final String? phonenumber;

  // ignore: use_key_in_widget_constructors
  const Passwordscreen({this.phonenumber});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordscreenState createState() => _PasswordscreenState();
}

class _PasswordscreenState extends State<Passwordscreen> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? bookingId;
  String? userId;
  bool isLoading = false;

  // ignore: non_constant_identifier_names
  String? Role;
  String? responseData;

  @override
  void  initState() {
    super.initState();
    getdata();
    //listenForOTP();
  }

  Future<void> verification() async {
    setState(() {
      isLoading = true;
    });

    try {
      const url = "https://masyseducare.com/masyseducarestudents.asmx/Verification";
      final body = {
        "Mobile": widget.phonenumber,
        "OTP": _passwordController.text,
        "GCM": "",
        "Role": Role,
      };
      final response = await http.post(Uri.parse(url), body: body);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final xmlDocument = xml.XmlDocument.parse(responseBody);
        // ignore: deprecated_member_use
        final xmlText = xmlDocument.findAllElements('string').first.text;

        setState(() {
          responseData = xmlText;
        });

        if (responseData == "\"Verification Done Successfully\"") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("log", "log");

          Future.delayed(const Duration(seconds: 2), () {

            // Move this part outside of setState()
            setState(() {
              isLoading = false;
            });
          });

          // Move the Navigator inside of setState()
          setState(() {
            Future.delayed(const Duration(seconds: 2), () {
              if(Role =="Parent"){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const GetStudentscreen()),
                      (route) => false,
                );
              }else if (Role =="Admin"){
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AdminPannelscreen()),
              (route) => false,
              );
              }

            });
          });
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text('User not registered.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        isLoading =false;
                      });
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (error) {
      // Handle any errors that occur during the asynchronous operation.
    }
  }


  void getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Role = pref.getString("role");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: MyColorTheme.primaryColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(

          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/login_design2.png"),
                  fit: BoxFit.cover, // Adjust the fit as needed
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), // Adjust the opacity value (0.5 in this example)
                    BlendMode.dstATop, // Adjust the blend mode if needed
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Lottie.asset(
                          'assets/Lottie/enterotp.json',
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Masys Educare",
                            style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Sit back And relax while we verifying your mobile number",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.phonenumber.toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColorTheme.primaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: "Enter Password",
                                  border: InputBorder.none
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                } else if (value != "masys@123" && value != "admin@123") {
                                  return 'Enter correct Password "masys@123"';
                                }
                                return null; // No validation error
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                // Check if the form is valid
                                if (_formKey.currentState?.validate() == true) {
                                  // Form is valid, proceed with OTP generation
                                  verification();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColorTheme.primaryColor,
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    MyColorTheme.primaryColor),
                              )
                                  : const Text(
                                'VERIFY & PROCEED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
