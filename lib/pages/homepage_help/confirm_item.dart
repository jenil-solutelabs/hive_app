import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/application/text.dart';

import '../../models/task_model.dart';

class ConfirmBox {
  final int index;
  ConfirmBox({required this.index});
  //show dialog box
  showAlertDialog(BuildContext context) {
    var provider = Provider.of<TaskModel>(context, listen: false);
    var itemWidth = MediaQuery.of(context).size.width;
    // Create buttons
    Widget yesButton = TextButton(
        onPressed: () {
          provider.removeItem(index);
          Navigator.pop(context);
          provider.getAllUser();
        },
        child: Container(
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(25)),
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Text(
              ApplicationText.yes,
              style: const TextStyle(color: Colors.white),
            )));
    Widget noButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Container(
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(25)),
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Text(
              ApplicationText.no,
              style: const TextStyle(color: Colors.white),
            )));
    // Create AlertDialog
    AlertDialog confirm = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text(ApplicationText.delete,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 1,
              fontWeight: FontWeight.w500)),
      content: Text(
        ApplicationText.confirmTitle,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
      ),
      backgroundColor: const Color(0xFF344FA1),
      actions: [yesButton, noButton],
    );
    // show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
              width: itemWidth > 600 ? 280 : 250,
              child: confirm,
          );
        });
  }
}
