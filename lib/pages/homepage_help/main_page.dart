import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:hive_app/Application/text.dart';
import 'package:hive_app/models/task_model.dart';
import 'package:hive_app/pages/homepage_help/category_show.dart';
import 'package:hive_app/pages/homepage_help/todoPage_help/data_grid.dart';
import 'package:hive_app/pages/homepage_help/todoPage_help/data_list.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<TaskModel>(context, listen: false).getAllUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskModel>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //greeting container
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          child: Text(ApplicationText.greet + " " + widget.name + "!!",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w700)),
        ),
        //category title
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16.0),
            child: Text(ApplicationText.category,
                style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                    fontFamily: 'Dongle',
                    letterSpacing: 1,
                    fontWeight: FontWeight.w100))),
        //category list
        const CategoryList(),
        //progress bar for task
        Container(
            padding: const EdgeInsets.all(16.0),
            child: GFProgressBar(
              percentage: provider.sum,
              lineHeight: 5,
              alignment: MainAxisAlignment.spaceBetween,
              leading:
                  const Icon(Icons.sentiment_dissatisfied, color: Colors.red),
              trailing:
                  const Icon(Icons.sentiment_satisfied, color: Colors.green),
              backgroundColor: const Color.fromRGBO(0, 0, 255, 1),
              progressBarColor: const Color.fromRGBO(255, 0, 255, 1),
            )),
        //task title
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(ApplicationText.todayTask,
                style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                    fontFamily: 'Dongle',
                    letterSpacing: 1,
                    fontWeight: FontWeight.w100))),
        //task list
        //Consumer for TaskModel
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => Consumer<TaskModel>(
              builder: (context, TaskModel data, child) {
                return data.pitem.isEmpty
                    ? Center(
                        child: Text(
                          ApplicationText.addSomeNote,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    : constraints.maxWidth > 700
                        ? DataGrid(
                            item: data.fresult.isNotEmpty
                                ? data.fresult
                                : data.pitem,
                          )
                        : DataList(
                            item: data.fresult.isNotEmpty
                                ? data.fresult
                                : data.pitem,
                          );
              },
              child: Center(
                child: Text(
                  ApplicationText.addTask,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 14, fontFamily: 'Dongle'),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
