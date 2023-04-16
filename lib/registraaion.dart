import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:login_registration/screens/login.dart';

import 'login.dart';

class RegistrationPage extends StatefulWidget {
  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  late String _mobileNumber;
  late String _UserName;
  late String _Email;
  late String _password;
  bool _isObscure = true;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _isNotValide = false;
  String? sa, sp;

  Future<String?> re() async {
    Map<String, dynamic> data = {
      'user': emailcontroller.text,
      'password': passwordcontroller.text
    };

    String jsonBody = json.encode(data);

    var response = await http.post(
      Uri.parse('http://192.168.29.55:3000/product/registration'),
      headers: {'Content-Type': 'application/json'},
      body: jsonBody,
    );
    Map<String, dynamic> user = jsonDecode(response.body);
    // print('$user{''}');

    if (emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty) {
      if (response.statusCode == 200) {
        showSuccessToast();
        var decoded = json.decode(response.body);
        print(decoded['status']);
        setState(() {
          if (decoded['status'] == true) {

            sp = "y";
          }
        });

        //sa=decoded['status'];

        // print(decoded);
        //   setState(() {
        //     sa = '${decoded}';
        //   });
      }
    } else {

    }
    if(response.statusCode==500){
      showSuccessToasts();
    }
    return sa;
  }

  void showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Registration successful! You can now login.",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20,
    );
  }

  void showSuccessToasts() {
    Fluttertoast.showToast(
      msg: " user exists! login please",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Center(
                        child: Text(
                          "SignUp",
                          textScaleFactor: 2,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    filled: true,
                    labelText: "User Name",
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your UserName';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _UserName = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    filled: true,
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _Email = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.phone_android_outlined,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    filled: true,
                    labelText: "Mobile Number",
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (value.length != 10) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _mobileNumber = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    filled: true,
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscure,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                SizedBox(height: 25.0),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50)),
                      child: Text(
                        'Registration',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      // onPressed: () {
                      //   if (_formKey.currentState!.validate()) {
                      //     _formKey.currentState!.save();
                      //
                      //     // TODO: Implement your login logic here
                      //
                      //     print('Mobile Number: $_mobileNumber');
                      //     print('Password: $_password');
                      //
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => LoginPage()));
                      //   }
                      // },
                      onPressed: () {

                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // TODO: Implement your login logic here

                          print('Mobile Number: $_mobileNumber');
                          print('Password: $_password');

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LoginPage()));
                          re();

                          if (sp == "y") {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          } else {}
                        }
                      }),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Alread'y have an account LogIn !...",
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
