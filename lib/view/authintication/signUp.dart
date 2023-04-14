import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfireproject/view/authintication/login.dart';
import 'package:get/get.dart';

import '../homePage.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final _mailController = TextEditingController();
  final _passController = TextEditingController();
  final myColor = Colors.deepPurple[400];
  String errorMsg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: myColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Sign-up",
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
                        .createUserWithEmailAndPassword(
                      email: _mailController.text,
                      password: _passController.text,
                    );
                    Get.to(() => HomePage());
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      errorMsg = 'The password provided is too weak.';
                    } else if (e.code == 'email-already-in-use') {
                      errorMsg = 'The account already exists for that email.';
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: myColor, borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "sign-up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("you have already an acount ?"),
                  TextButton(
                      onPressed: () {
                        Get.to(() => Login());
                      },
                      child: const Text(
                        "log-in",
                        style: TextStyle(color: Colors.deepPurple),
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
