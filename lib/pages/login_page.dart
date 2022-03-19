import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/application/text.dart';
import 'package:hive_app/models/home_argurments.dart';
import 'package:hive_app/models/student_model.dart';
import 'package:hive_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isobsecure = true;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  late final Box box;

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        width: kIsWeb ? 450 : null,
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        )));
  }

  void onLoginSuccess(Student? student) async {
    if (student != null) {
      var st = Student(
          firstname: student.firstname,
          lastname: student.lastname,
          username: student.username,
          email: student.email,
          password: student.password,
          date: student.date,
          grade: student.grade,
          status: true);
      box.putAt(0, st);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        ApplicationText.loginSuccess,
        style: const TextStyle(color: Colors.white),
      )));
      Navigator.pushReplacementNamed(context, HomePage.homerouteName,
          arguments: HomeAgruments(name: student.username));
    } else {
      _showSnackBar("Invalid Username or Password");
    }
  }

  void _submit() {
    final form = _formkey.currentState;
    if (form!.validate()) {
      List<Student> stud = <Student>[box.getAt(0)];
      if (stud.isNotEmpty) {
        if (stud.first.username == name.text &&
            stud.first.password == pass.text) {
          onLoginSuccess(stud.first);
        } else {
          _showSnackBar('Invalid username or password');
        }
      }
    } else {
      _showSnackBar("All Fields are requied!!");
    }
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box('Students');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        //footer
        persistentFooterButtons: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: Text(ApplicationText.footer,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Dongle',
                        fontSize: 30)),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      name.clear();
                      pass.clear();
                      _autovalidateMode = AutovalidateMode.disabled;
                    });
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/register', ModalRoute.withName('/login'));
                  },
                  child: Text(
                    ApplicationText.lresgister,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 0, 255, 1),
                        fontFamily: 'Dongle',
                        fontSize: 30),
                  )),
            ],
          )
        ],
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //title for login page
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                padding: const EdgeInsets.symmetric(vertical: 80),
                alignment: Alignment.center,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.check,
                      size: 60.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              //form for login page
              Form(
                key: _formkey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  children: <Widget>[
                    //title of form 'Enter your name'
                    Container(
                      alignment: Alignment.center,
                      child: Text(ApplicationText.titleForm,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'Dongle',
                              fontWeight: FontWeight.w800)),
                    ),
                    //username form field
                    Container(
                      width: kIsWeb ? 450 : null,
                      height: 55,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value == '') {
                            return 'Enter Username';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(height: 0.3),
                          contentPadding: const EdgeInsets.only(
                              left: 11, right: 3, top: 12, bottom: 10),
                          errorStyle:
                              const TextStyle(fontSize: 12, height: 0.3),
                          border: InputBorder.none,
                          icon: const Icon(Icons.person),
                          labelText: ApplicationText.username,
                        ),
                      ),
                    ),
                    //password form field
                    Container(
                      width: kIsWeb ? 450 : null,
                      height: 55,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextFormField(
                        controller: pass,
                        validator: (value) {
                          if (value == '') {
                            return 'Enter Password';
                          }
                          return null;
                        },
                        obscureText: isobsecure,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isobsecure = !isobsecure;
                                });
                              },
                              icon: Icon(isobsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          labelStyle: const TextStyle(height: 0.3),
                          contentPadding: const EdgeInsets.only(
                              left: 11, right: 3, top: 12, bottom: 10),
                          errorStyle:
                              const TextStyle(fontSize: 12, height: 0.3),
                          border: InputBorder.none,
                          icon: const Icon(Icons.lock),
                          labelText: ApplicationText.password,
                        ),
                      ),
                    ),
                    //Login button
                    TextButton(
                      child: Container(
                        width: kIsWeb ? 450 : null,
                        height: 50,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 0, 255, 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          ApplicationText.login,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Dongle',
                              fontSize: 30),
                        ),
                      ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          _autovalidateMode = AutovalidateMode.always;
                        });
                        _submit();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
