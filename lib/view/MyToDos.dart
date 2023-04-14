import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfireproject/view/layout/components/bottomsheet.dart';

class MyToDos extends StatefulWidget {
  @override
  _MyToDos createState() => _MyToDos();
}

class _MyToDos extends State<MyToDos> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _toDoStream =
      FirebaseFirestore.instance.collection('toDos').snapshots();
  TextEditingController updatedToDoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: const Text('My ToDos'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _toDoStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff413543)),
                        child:
                            Text(data['toDo'], overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red),
                      child: IconButton(
                        padding: EdgeInsets.all(5),
                        constraints: BoxConstraints(),
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('toDos')
                              .doc(document.id)
                              .delete()
                              .then((value) => print("User deleted"))
                              .catchError((error) =>
                                  print("Failed to delete user: $error"));
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.amber),
                      child: IconButton(
                        padding: EdgeInsets.all(5),
                        constraints: BoxConstraints(),
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                return myBottomSheet(
                                    controller: updatedToDoController,
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection('toDos')
                                          .doc(document.id)
                                          .update({
                                            'toDo': updatedToDoController.text
                                          })
                                          .then(
                                              (value) => print("User Updated"))
                                          .catchError((error) => print(
                                              "Failed to update user: $error"));
                                      Navigator.pop(context);
                                      updatedToDoController.text = '';
                                    });
                              });
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
