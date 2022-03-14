import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:hive_app/application/text.dart';
import 'package:hive_app/models/task_model.dart';
import 'package:hive_app/pages/homepage_help/category_show.dart';
import 'package:hive_app/pages/homepage_help/todo_page.dart';
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
    Provider.of<TaskModel>(context, listen: false).getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskModel>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
              percentage: provider.progress(),
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
        const Expanded(child: TodoList())
      ],
    );
  }
}
