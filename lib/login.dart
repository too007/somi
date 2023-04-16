import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:som/home.dart';
import 'package:som/registraaion.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  late String _mobileNumber;
  late String _password;
  bool _isObscure = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String? statusText;
  bool isLoggedIn = false;







  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }

  Future<void> login(String email, String password) async {
    Map<String, dynamic> data = {'user': email, 'password': password};
    String jsonBody = json.encode(data);

    var response = await http.post(
      Uri.parse('http://192.168.29.55:3000/product/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      setState(() {
        statusText = "Login successful!";
        showSuccessToast();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      });
    } else {
      setState(() {
        statusText = "Invalid email or password";
      });
    }
  }

  void showSuccessToast() {
    Fluttertoast.showToast(
      msg: "login successful! .",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20,
    );
  }

  void showErrorToast() {
    Fluttertoast.showToast(
      msg: "Invalid email or password",
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
                          "Login",
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
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 105)),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password :(",
                          style: TextStyle(color: Colors.black54),
                        )),
                  ],
                ),
                SizedBox(height: 0.0),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50)),
                    child: Text(
                      'Login',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                    //             builder: (context) => RegistrationPage()));
                    //   }
                    // },
                    onPressed: () async {
                      String email = emailcontroller.text.trim();
                      String password = passwordcontroller.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        setState(() {
                          statusText = "Email and password are required";
                        });
                        return;
                      }

                      await login(email, password);
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()));
                  },
                  child: Text(
                    "Don't have an account Register !...",
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