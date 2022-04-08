import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/application/text.dart';
import 'package:hive_app/models/item_model.dart';
import 'package:hive_app/models/task_model.dart';

// ignore: must_be_immutable
class UpdateItem {
  final int index;
  final Item item;
  UpdateItem({required this.item, required this.index});

  //show dialog box
  showAlertDialog(BuildContext context) {
    final _formEdit = GlobalKey<FormState>();
    var itemWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<TaskModel>(context, listen: false);
    TextEditingController title = TextEditingController(text: item.body);
    // Create button
    Widget okButton = TextButton(
      child: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(25)),
          alignment: Alignment.center,
          child: Text(ApplicationText.save,
              style: const TextStyle(color: Colors.white))),
      onPressed: () {
       if(_formEdit.currentState!.validate()){
         var itm = Item(body: title.text, check: item.check);
         provider.updateItem(itm, index);
         Navigator.of(context).pop();
         provider.getAllUser();
       }
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Row(
        children: <Widget>[
          Text(ApplicationText.updateTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500)),
          Container(
            margin: EdgeInsets.only(left: itemWidth > 600 ? 100 : 60),
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              child: const Icon(
                Icons.clear,
                color: Colors.white60,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      content: Form(
        key: _formEdit,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: itemWidth > 600 ? 280 : 250,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: title,
                validator: (value){
                  if(value == ''){
                    return 'Enter Some Title Here';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 11, right: 3, top: 12, bottom: 10),
                    errorStyle:
                    const TextStyle(fontSize: 12, height: 0.3),
                    hintText: ApplicationText.enterTitle),
              )),
        ],
      ),
      ),
      backgroundColor: const Color(0xFF344FA1),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: alert,
          );
        });
  }
}
