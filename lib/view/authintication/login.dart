import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfireproject/view/authintication/signUp.dart';
import 'package:flutterfireproject/view/homePage.dart';
import 'package:flutterfireproject/view/layout/appLayout.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _mailController = TextEditingController();

  final _passController = TextEditingController();

  final myColor = Colors.deepPurple[400];

  String ErrorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: myColor,
          automaticallyImplyLeading: false,
          title: const Text(
            "Log-In",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: _mailController,
                  decoration: const InputDecoration(
                      labelText: "Email", border: OutlineInputBorder())),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password", border: OutlineInputBorder())),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _mailController.text,
                            password: _passController.text);
                    Get.to(() => AppLayout());
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ErrorMsg = 'No user found for that email.';
                      setState(() {});
                    } else if (e.code == 'wrong-password') {
                      ErrorMsg = 'Wrong password provided for that user.';
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: myColor, borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              Text(
                ErrorMsg,
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("you don't have already an acount ?"),
                  TextButton(
                      onPressed: () {
                        Get.to(() => SignUp());
                      },
                      child: const Text(
                        "sign-up",
                        style: TextStyle(color: Colors.deepPurple),
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
