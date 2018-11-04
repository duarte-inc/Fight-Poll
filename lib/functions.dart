import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mma_poll/settings.dart';
// ------------------------- SOME COMMON FUNCTIONS --------------------------

String dateFormaterA(DateTime timeInput) {
  dynamic date;
  if (DateTime.now().year - timeInput.year != 0) {
    date = (DateTime.now().year - timeInput.year).abs();
    date = "$date years";
  } else if (DateTime.now().month - timeInput.month != 0) {
    date = (DateTime.now().month - timeInput.month).abs();
    date = "$date months";
  } else if (DateTime.now().day - timeInput.day != 0) {
    date = (DateTime.now().day - timeInput.day).abs();
    date = "$date days";
  } else if (DateTime.now().hour - timeInput.hour != 0) {
    date = (DateTime.now().hour - timeInput.hour).abs();
    date = "$date hours";
  } else if (DateTime.now().minute - timeInput.minute != 0) {
    date = (DateTime.now().minute - timeInput.minute).abs();
    date = "$date minutes";
  } else {
    date = (DateTime.now().second - timeInput.second).abs();
    date = "$date seconds";
  }
  return date;
}

//-------------------------------------------------------------------
String viewRounderA(int viewInput) {
  int views = viewInput;
  String viewStr = views.toString();
  int length = viewStr.length;
  String sign;

  //Below 1000 will return the view itself without sign
  if ((views % 1000) == views) {
    return views.toString();
  }

  //Making sure the length of the views is greater than i, but their difference should not surpase 3.
  for (int i = 3; i < length; i = i + 3) {
    int power = pow(10, i);
    if (length > i && (length - i) <= 3) {
      double f = views / power;
      if (power == pow(10, 3)) {
        sign = "K";
      } else if (power == pow(10, 6)) {
        sign = "M";
      } else if (power == pow(10, 9)) {
        sign = "B";
      }
      return f.round().toString() + sign;
    }
  }
  return views.toString();
}

//-----------------------------AppBar-----------------------------------
Widget appBarAll(
    BuildContext context, String title, String title1, bool status) {
  return AppBar(
    leading: new IconButton(
      iconSize: 30.0,
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Container(
      alignment: Alignment.center,
      child: Text(status ? title : title1),
    ),
    actions: <Widget>[
      IconButton(
        iconSize: 30.0,
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Settings(),
            ),
          );
        },
        tooltip: 'settings',
      )
    ],
  );
}

Widget appBarSettings(BuildContext context, title) {
  return AppBar(
    leading: IconButton(
      iconSize: 30.0,
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Container(
      padding: EdgeInsets.only(right: 44.0),
      alignment: Alignment.center,
      child: Text(title),
    ),
  );
}
