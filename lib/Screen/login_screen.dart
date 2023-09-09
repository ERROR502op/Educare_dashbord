import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:masys_educare/Alert/privacypolicy.dart';
import 'package:masys_educare/Model/mytheme.dart';
import 'package:masys_educare/Screen/passwordscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<_LoginScreenState> _loginScreenStateKey =
      GlobalKey<_LoginScreenState>();
  String? phoneNumberError;
  String? selectedRole;
  String responseData = ''; // Store response data from web service
  final List<String> roleList = ['Student', 'Parent', 'Admin', 'Faculty'];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void generateOtp() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("phonenumber", phoneController.text);
    pref.setString("role", selectedRole.toString());

    const url =
        "https://masyseducare.com/masyseducarestudents.asmx/GenerateOTP";
    final studentbody = {
      "Mobile": phoneController.text,
      "role": selectedRole.toString(),
    };
    final adminbody = {
      "Mobile": phoneController.text,
      "role": selectedRole.toString(),
    };
    final studentresponse = await http.post(Uri.parse(url), body: studentbody);
    final adminresponse = await http.post(Uri.parse(url), body: adminbody);

    if (studentresponse.statusCode == 200 || adminresponse.statusCode == 200) {
      final responseBody = studentresponse.body;
      final xmlDocument = xml.XmlDocument.parse(responseBody);
      // ignore: deprecated_member_use
      final xmlText = xmlDocument.findAllElements('string').first.text;
      setState(() {
        responseData = xmlText;
        if (responseData == "\"OTP Send Successfully-Student\"" ||
            responseData == "\"OTP Send Successfully-Parent\"" ||
            responseData == "\"OTP Send Successfully-Admin\"" ||
            responseData == "\"OTP Send Successfully-Faculty\"") {
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              isLoading = false;
            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Privacy Policy'),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                            'It is important that you understand what information app collects and uses.\n '),
                        Text(
                            'App uses collected information for the following general purposes: products and services provision, billing, identification and authentication, services improvement, contact, and research.'),
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Name to establish the identity of users and maintain their accounts."),
                        Divider(),
                        Text(
                          "Phone Number",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),

                        Text(
                            "App uses Phone number for login purposes and to show them on the profile or to contact you."),
                        Divider(),
                        Text(
                          "Images And Videos",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),

                        Text(
                            "We collect User images in some cases as mandated to show them on the profile. We do not collect video files."),
                        Divider(),
                        Text(
                          "Flies and Documents",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "PDFs - We collect user file in PDF format. We do not collect any other files."),
                        Divider(),
                        Text(
                            "Important: Please be assured that the app does not collect or share any of your personal or sensitive data."),
                        // Add more Text widgets to display your privacy policy content
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Text color
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.purple.shade900), // Background color
                      ),
                      child: const Text('I Agree'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Passwordscreen(
                              phonenumber: phoneController.text,
                            ),
                          ),
                        ); // Close the dialog
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
              },
            );
          });
        } else {
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
                        isLoading = false;
                      });
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/login_design.png"),
                fit: BoxFit.cover, // Adjust the fit as needed
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  // Adjust the opacity value (0.5 in this example)
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 300,
                        child: Image.asset("assets/Design/masystechnew.png")),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Masys Educare',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // Apply padding as needed
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "Enter Mobile Number",
                          border: InputBorder.none, // Remove the under line
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mobile number is required';
                          } else if (value.length != 10) {
                            return 'Mobile number must be 10 digits long';
                          }
                          return null; // No validation error
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      //
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Role',

                        ),
                        value: selectedRole,
                        items: roleList.map((role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedRole = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Role selection is required'; // Validation error message
                          }
                          return null; // No validation error
                        },
                      ),

                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'By continuing you agree to our ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const PrivacyPolicyDialog();
                                  },
                                );
                              },
                          ),
                          const TextSpan(
                            text: ' and ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                // Check if the form is valid
                                if (_formKey.currentState?.validate() == true) {
                                  // Form is valid, proceed with OTP generation
                                  generateOtp();
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
                                'GET LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
