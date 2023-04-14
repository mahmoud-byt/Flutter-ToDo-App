import 'package:flutter/material.dart';
import 'package:flutterfireproject/view/MyToDos.dart';
import 'package:flutterfireproject/view/homePage.dart';

class AppLayout extends StatefulWidget {
  AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _currentIndex = 0;
  List<Widget> pages = [HomePage(), MyToDos()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            _currentIndex = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "ADD TODO"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "TODOS"),
          ]),
      body: pages[_currentIndex],
    );
  }
}
