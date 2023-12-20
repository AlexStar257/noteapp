import 'package:flutter/material.dart';
import 'package:noteapp/pages/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Add a new task',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Cancel button
              Mybutton(text: 'CANCEL', onPressed: onCancel),
              //Save button
              Mybutton(text: 'ADD', onPressed: onSave),
            ],
          )
        ]),
      ),
    );
  }
}
