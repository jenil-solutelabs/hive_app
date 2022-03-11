import 'package:flutter/material.dart';
import 'package:hive_app/application/text.dart';

//drawer list
class DrawerList extends StatelessWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //drawer
    return Drawer(
      backgroundColor: const Color.fromRGBO(0, 33, 71, 1),
      //list view for drawe
      child: ListView(
        children: <Widget>[
          //logo for app
          DrawerHeader(
              child: Center(
                  child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF344FA1)),
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.check,
              size: 30.0,
              color: Colors.white,
            ),
          ))),
          // Rate us
          ListTile(
              leading: const Icon(Icons.star, color: Colors.white60),
              title: Text(
                ApplicationText.drawerRateus,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )),
          //Share app
          ListTile(
              leading: const Icon(Icons.share, color: Colors.white60),
              title: Text(
                ApplicationText.drawerShare,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )),
          //app privacy policy
          ListTile(
              leading: const Icon(
                Icons.perm_device_info,
                color: Colors.white60,
              ),
              title: Text(
                ApplicationText.drawerPriavcy,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )),
          //app version
          ListTile(
            leading: const Icon(
              Icons.verified_sharp,
              color: Colors.white60,
            ),
            title: Text(
              ApplicationText.drawerVersion,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              ApplicationText.drawerVersionCount,
              style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
