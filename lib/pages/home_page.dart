import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/application/text.dart';
import 'package:hive_app/pages/homepage_help/add_item.dart';
import 'package:hive_app/pages/homepage_help/category_show.dart';
import 'package:hive_app/pages/homepage_help/drawer_list.dart';
import 'package:hive_app/pages/homepage_help/todo_page.dart';
import 'package:hive_app/models/task_model.dart';
import 'package:getwidget/getwidget.dart';

//home page for todo app
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name}) : super(key: key);
  static const homerouteName = '/home';
  final String name;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false;
  // ignore: prefer_final_fields
  TextEditingController _searchQuery = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<TaskModel>(context, listen: false).getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskModel>(context);
    //Scaffold wigdet of material app
    return Scaffold(
      key: scaffoldKey,
      //app bar
      appBar: AppBar(
        leading: _isSearching
            ? const BackButton()
            : IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
        title: _isSearching ? _buildSearchField() : null,
        automaticallyImplyLeading: true,
        actions: _buildActions(),
      ),
      //drawer
      drawer: const DrawerList(),
      //add task
      floatingActionButton: Container(
        margin: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            AddItem().showAlertDialog(context);
          },
          tooltip: ApplicationText.tooltip,
          backgroundColor: const Color.fromRGBO(255, 0, 255, 1),
          child: const Icon(Icons.add),
        ),
      ),
      //main page column
      body: Column(
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
      ),
    );
  }

  //start search
  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  //stop search
  void _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  //clear search
  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
    });
    updateSearchQuery("");
  }

  //search field
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: InputDecoration(
          hintText: ApplicationText.serach,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.white60)),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  //updating serach query
  void updateSearchQuery(String newQuery) {
    Provider.of<TaskModel>(context, listen: false).filterSearch(newQuery);
  }

  //create actions
  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
            onPressed: () {
              if (_searchQuery.text.isEmpty) {
                Navigator.pop(context);
                return;
              }
              _clearSearchQuery();
            },
            icon: const Icon(Icons.clear)),
      ];
    } else {
      return <Widget>[
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              size: 28,
            )),
      ];
    }
  }
}
