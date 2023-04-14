import 'package:flutter/material.dart';

class myBottomSheet extends StatelessWidget {
  myBottomSheet({super.key, required this.onTap,required this.controller});
  Function()? onTap;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        color: Color(0xff4C4B16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54)))),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Edit",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
