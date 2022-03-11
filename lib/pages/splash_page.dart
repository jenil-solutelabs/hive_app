import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_app/models/home_argurments.dart';
import 'package:hive_app/models/student_model.dart';
import 'package:hive_app/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final Box box;
  //check for user
  Future<bool> check() async {
    final check = box.values.cast<Student>();
    if (check.isNotEmpty) {
      return check.first.status;
    } else {
      return false;
    }
  }

  //fetching username
  Future<String> getUsername() async {
    final result = box.values.cast<Student>();
    if (result.isNotEmpty) {
      return result.first.username;
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box('Students');
    Timer(const Duration(seconds: 2), () async {
      //await getDetails();
      await check()
          ? Navigator.pushReplacementNamed(context, HomePage.homerouteName,
              arguments: HomeAgruments(name: await getUsername()))
          : Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 82, 186, 1),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(bottom: 4),
          child: const Icon(
            Icons.check,
            size: 60.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
