import 'package:flutter/material.dart';
import 'package:hive_app/models/item_model.dart';
import 'package:hive_app/models/task_model.dart';
import 'package:hive_app/pages/homepage_help/confirm_item.dart';
import 'package:hive_app/pages/homepage_help/update_item.dart';
import 'package:provider/provider.dart';

//List View For Showing List of note
class DataList extends StatelessWidget {
  const DataList({Key? key, required this.item}) : super(key: key);
  final List<Item> item;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskModel>(context, listen: false);
    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        itemCount: item.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 33, 71, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                  leading: InkWell(
                    onTap: () {
                      provider.toogleTask(item[index], index);
                      provider.getAllUser();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: item[index].check
                              ? null
                              : Border.all(
                                  width: 1.5,
                                  color: index % 2 == 0
                                      ? const Color.fromRGBO(255, 0, 255, 1)
                                      : Colors.blue)),
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: item[index].check
                                  ? Colors.blue.shade900
                                  : Colors.transparent),
                          alignment: Alignment.center,
                          //padding: const EdgeInsets.all(4.0),
                          child: item[index].check
                              ? const Icon(
                                  Icons.check,
                                  size: 16.0,
                                  color: Colors.white,
                                )
                              : null),
                    ),
                  ),
                  title: Text(
                    item[index].body,
                    style: TextStyle(
                        decoration: item[index].check == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Future.delayed(Duration.zero, () {
                              UpdateItem(item: item[index], index: index)
                                  .showAlertDialog(context);
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white60,
                          )),
                      IconButton(
                          onPressed: () {
                            Future.delayed(Duration.zero, () {
                              ConfirmBox(index: index).showAlertDialog(context);
                            });
                          },
                          icon: const Icon(Icons.clear, color: Colors.white60)),
                    ],
                  )));
        });
  }
}
