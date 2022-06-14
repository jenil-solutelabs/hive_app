import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_app/pages/register_help/register_form.dart';
import 'package:hive_app/Application/text.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          automaticallyImplyLeading: kIsWeb ? false : true,
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(ApplicationText.rfooter,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Dongle', fontSize: 30)),
            ),
            TextButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/login'));
                },
                child: Text(
                  ApplicationText.rlogin,
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
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(ApplicationText.regisTitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Dongle',
                        fontWeight: FontWeight.w500))),
            Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(ApplicationText.regisSubtitle,
                    style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 25,
                        fontFamily: 'Dongle',
                        fontWeight: FontWeight.w500))),
            const RegisterForm()
          ],
        ),
      ),
    );
  }
}
