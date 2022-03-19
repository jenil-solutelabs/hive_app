import 'package:flutter/material.dart';
import 'package:hive_app/pages/homepage_help/main_page.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/application/text.dart';
import 'package:hive_app/pages/homepage_help/add_item.dart';
import 'package:hive_app/pages/homepage_help/drawer_list.dart';
import 'package:hive_app/models/task_model.dart';

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
  bool _isOpen = true;
  // ignore: prefer_final_fields
  TextEditingController _searchQuery = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    const breakPoint = 600;
    if (screenSize >= breakPoint) {
      //Scaffold wigdet of material app
      return Row(
        children: [
          //drawer
          if (_isOpen)
            const SizedBox(
              width: 300,
              child: DrawerList(),
            ),
          Expanded(
              child: Scaffold(
            key: scaffoldKey,
            //app bar
            appBar: AppBar(
              leading: _isSearching
                  ? const BackButton()
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _isOpen = !_isOpen;
                        });
                      },
                      icon: const Icon(Icons.menu),
                    ),
              title: _isSearching ? _buildSearchField() : _buildCategory(),
              automaticallyImplyLeading: true,
              actions: _buildActions(),
            ),
            //add task
            floatingActionButton: Container(
              margin: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Future.delayed(Duration.zero, () {
                    AddItem().showAlertDialog(context);
                  });
                },
                tooltip: ApplicationText.tooltip,
                backgroundColor: const Color.fromRGBO(255, 0, 255, 1),
                child: const Icon(Icons.add),
              ),
            ),
            //main page column
            body: MainPage(name: widget.name),
          ))
        ],
      );
    } else {
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
          title: _isSearching ? _buildSearchField() : _buildCategory(),
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
              Future.delayed(Duration.zero, () {
                AddItem().showAlertDialog(context);
              });
            },
            tooltip: ApplicationText.tooltip,
            backgroundColor: const Color.fromRGBO(255, 0, 255, 1),
            child: const Icon(Icons.add),
          ),
        ),
        //main page column
        body: MainPage(name: widget.name),
      );
    }
  }

  //start search
  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
    updateSearchQuery("");
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

  //category field
  var list = [
    'All Lists',
    'Default',
    'Personal',
    'Shopping',
    'Wishlist',
    'Work',
  ];
  String dropDownValue = 'All Lists';
  Widget _buildCategory() {
    return Container(
      alignment: Alignment.centerLeft,
      child: DropdownButton(
          underline: const SizedBox(),
          value: dropDownValue,
          dropdownColor: Colors.blue,
          style: const TextStyle(color: Colors.white),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
          items: list.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: SizedBox(
                width: 150,
                child: ListTile(
                  title: Text(
                    items,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue!;
            });
          }),
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
