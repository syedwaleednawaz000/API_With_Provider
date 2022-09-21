import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  bool loadingSignUp = false;

  // https://reqres.in/api/register

  var data;

  void logIn({required String email, required String password}) async {
    // loading = true;
    try {
      loading = true;
      final response =
          await http.post(Uri.parse("https://reqres.in/api/login"), body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        loading = false;
        data = jsonDecode(response.body.toString());
        print("successfully login${data['token']}");
      } else {
        loading = false;
        print(" status code ${response.statusCode.toString()}");
      }
    } catch (e) {
      loading = false;
      print(e.toString());
    }
  }

  void signUp({required String email, required String password}) async {
    loadingSignUp = true;
    try {
      loadingSignUp = true;
      final response =
          await http.post(Uri.parse("https://reqres.in/api/register"), body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        loadingSignUp = false;
        data = jsonDecode(response.body.toString());
        print("successfully login");
      } else {
        loadingSignUp = false;
        print(" status code ${response.statusCode.toString()}");
      }
    } catch (e) {
      setState(() {
        loadingSignUp = false;

      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LogIn adn SignIn"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.030),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: "Email"),
          ),
          SizedBox(height: Get.height * 0.030),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(hintText: "Password"),
          ),
          SizedBox(height: Get.height * 0.030),
          GestureDetector(
            onTap: () {
              setState(() {});
              logIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim());
            },
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              width: Get.width * 1,
              child: Center(
                child: loading ? CircularProgressIndicator() : Text("LogIn"),
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              setState(() {});
              signUp(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim());
            },
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              width: Get.width * 1,
              child: Center(
                child: loadingSignUp ? CircularProgressIndicator() : Text("SignIn"),
              ),
            ),
          )

        ],
      ),
    );
  }
}
