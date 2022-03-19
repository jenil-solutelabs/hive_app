import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_app/Application/text.dart';

// ignore: must_be_immutable
class RateUs {
  //show dialog box
  showAlertDialog(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width;
    // Create button
    Widget okButton = TextButton(
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(25)),
        alignment: Alignment.center,
        child: Text(ApplicationText.submit,
            style: const TextStyle(color: Colors.white)),
      ),
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          ApplicationText.thankYouFeedBack,
          style: const TextStyle(color: Colors.white),
        )));
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Row(
        children: <Widget>[
          Text(ApplicationText.giveFeedBack,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500)),
          Container(
            margin: EdgeInsets.only(left: itemWidth > 600 ? 100 : 60),
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              child: const Icon(
                Icons.clear,
                color: Colors.white60,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: itemWidth > 600 ? 280 : 250,
            child: RatingBar.builder(
              initialRating: 3,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return const Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return const Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return const Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 4:
                    return const Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                  default:
                    return Container();
                }
              },
              updateOnDrag: true,
              onRatingUpdate: (rating) {},
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF344FA1),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: alert,
          );
        });
  }
}
