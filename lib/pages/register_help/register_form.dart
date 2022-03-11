import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/application/text.dart';
import 'package:hive_app/models/student_model.dart';
import 'package:hive_app/models/validation_register.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isObsecure = true;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController tgrade = TextEditingController();
  DateTime currentDate = DateTime.now();
  String dropdownvalue = 'A';
  String daterror = 'Birthdate is required';
  late final Box box;
  var grade = ['A', 'B', 'C', 'D'];

  //date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(1970, 1, 1),
        firstDate: DateTime(1970),
        lastDate: DateTime(2001),
        errorFormatText: 'Select your birth date');
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        daterror = '';
        String pdate = DateFormat("d MMMM y").format(pickedDate);
        date.text = pdate;
      });
    }
  }

  //form submit
  Future<void> _submit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      var student = Student(
          firstname: fname.text,
          lastname: lname.text,
          username: user.text,
          email: email.text,
          password: pass.text,
          date: date.text,
          grade: tgrade.text,
          status: false);
      box.add(student);
      form.reset();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        ApplicationText.registerSuccess,
        style: const TextStyle(color: Colors.white),
      )));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        ApplicationText.allrequied,
        style: const TextStyle(color: Colors.white),
      )));
    }
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box('Students');
  }

  @override
  Widget build(BuildContext context) {
    ValidationRegister validationService = ValidationRegister();
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //firstname form field
          Container(
              height: 55,
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: TextFormField(
                  controller: fname,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    String? err =
                        validationService.changeFirstName(value.toString());
                    return err;
                  },
                  decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      labelText: ApplicationText.firstname,
                      labelStyle: const TextStyle(height: 1),
                      contentPadding: const EdgeInsets.only(
                          left: 0, right: 3, top: 8, bottom: 8),
                      errorStyle: const TextStyle(fontSize: 12, height: 0.3),
                      border: InputBorder.none))),
          //Lastname form field
          Container(
              height: 55,
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: TextFormField(
                  controller: lname,
                  validator: (value) {
                    String? err =
                        validationService.changeLastName(value.toString());
                    return err;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      labelStyle: const TextStyle(height: 1),
                      contentPadding: const EdgeInsets.only(
                          left: 0, right: 3, top: 8, bottom: 8),
                      errorStyle: const TextStyle(fontSize: 12, height: 0.3),
                      labelText: ApplicationText.lastname,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      )))),
          //username form Field
          Container(
              height: 55,
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: TextFormField(
                  controller: user,
                  validator: (value) {
                    String? err =
                        validationService.changeUserName(value.toString());
                    return err;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.person_add_rounded),
                      labelStyle: const TextStyle(height: 1),
                      contentPadding: const EdgeInsets.only(
                          left: 0, right: 3, top: 8, bottom: 8),
                      errorStyle: const TextStyle(fontSize: 12, height: 0.3),
                      labelText: ApplicationText.username,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      )))),
          //Email Address form field
          Container(
              height: 55,
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: TextFormField(
                  controller: email,
                  validator: (value) {
                    String? err =
                        validationService.changeEmail(value.toString());
                    return err;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      labelStyle: const TextStyle(height: 1),
                      contentPadding: const EdgeInsets.only(
                          left: 0, right: 3, top: 8, bottom: 8),
                      errorStyle: const TextStyle(fontSize: 12, height: 0.3),
                      labelText: ApplicationText.emailaddress,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      )))),
          //Password form field
          Container(
              height: 55,
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: TextFormField(
                  controller: pass,
                  validator: (value) {
                    String? err =
                        validationService.changePass(value.toString());
                    return err;
                  },
                  obscureText: isObsecure,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          },
                          icon: Icon(isObsecure
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      labelStyle: const TextStyle(height: 1),
                      contentPadding: const EdgeInsets.only(
                          left: 0, right: 3, top: 8, bottom: 8),
                      errorStyle: const TextStyle(fontSize: 12, height: 0.3),
                      labelText: ApplicationText.password,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      )))),
          //Date of Birth form field
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: TextFormField(
              controller: date,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                _selectDate(context);
              },
              validator: (value) {
                if (value == '') {
                  return 'Birth Date is required';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: ApplicationText.dob,
                labelStyle: const TextStyle(height: 1),
                contentPadding:
                    const EdgeInsets.only(left: 0, right: 3, top: 8, bottom: 8),
                icon: const Icon(Icons.calendar_today),
                errorStyle: const TextStyle(fontSize: 12, height: 0.3),
                border: const UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          //Grade form field
          Container(
              height: 55,
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: DropdownButtonFormField(
                  value: dropdownvalue,
                  elevation: 4,
                  icon: const SizedBox.shrink(),
                  validator: (value) {
                    if (value == null) {
                      return 'choose grade';
                    }
                    return null;
                  },
                  items: grade.map((String grade) {
                    return DropdownMenuItem(value: grade, child: Text(grade));
                  }).toList(),
                  decoration: InputDecoration(
                    icon: const Icon(Icons.grade),
                    border: InputBorder.none,
                    labelStyle: const TextStyle(height: 1),
                    contentPadding: const EdgeInsets.only(
                        left: 0, right: 3, top: 8, bottom: 8),
                    labelText: ApplicationText.grade,
                  ),
                  onChanged: (String? newGrade) {
                    setState(() {
                      dropdownvalue = newGrade!;
                    });
                  })),
          //regiseter Button
          Container(
              height: 55,
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 0, 255, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: TextButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _autoValidate = AutovalidateMode.always;
                    });
                    _submit();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(ApplicationText.resgister,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Dongle',
                              fontSize: 30)))))
        ],
      ),
    );
  }
}
