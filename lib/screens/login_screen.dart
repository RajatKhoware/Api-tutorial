import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void login(String email, password) async {
    try {
      http.Response res =
          await post(Uri.parse("https://reqres.in/api/register"),
              // for login just replace api/register register with api/login that's it !!
              body: {'email': email, 'password': password});
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print("Account created !!");
        print(data);
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp & LogIn"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextFormField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                  hintText: "Enter your email here !", labelText: "Email"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordcontroller,
              decoration: const InputDecoration(
                  hintText: "Enter your password here !",
                  labelText: "Password"),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                login(emailcontroller.text.toString(),
                    passwordcontroller.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text("Login"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
