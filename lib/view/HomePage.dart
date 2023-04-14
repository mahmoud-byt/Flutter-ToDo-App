import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _toDoController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String toDoBody;
  @override
  Widget build(BuildContext context) {
    CollectionReference toDos = FirebaseFirestore.instance.collection('toDos');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple[400],
          automaticallyImplyLeading: false,
          title: const Text(
            "ToDo App",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: _toDoController,
                  decoration: const InputDecoration(
                      labelText: "Enter your new Todo",
                      border: OutlineInputBorder())),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (_toDoController.text != "") {
                    toDos
                        .add({
                          'toDo': _toDoController.text,
                        })
                        .then((value) => print("toDos Added"))
                        .catchError(
                            (error) => print("Failed to add user: $error"));
                  }
                  _toDoController.text = "";
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[400],
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "ADD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
