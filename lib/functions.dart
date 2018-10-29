import 'dart:math';
import 'package:flutter/material.dart';

// ------------------------- SOME COMMON FUNCTIONS --------------------------

String dateFormaterA(DateTime timeInput) {
  dynamic date;
  if (DateTime.now().year - timeInput.year != 0) {
    date = DateTime.now().year - timeInput.year;
    date = "$date years ago";
  } else if (DateTime.now().month - timeInput.month != 0) {
    date = (DateTime.now().month - timeInput.month).abs();
    date = "$date monthes ago";
  } else if (DateTime.now().day - timeInput.day != 0) {
    date = DateTime.now().day - timeInput.day;
    date = "$date days ago";
  } else if (DateTime.now().hour - timeInput.hour != 0) {
    date = DateTime.now().hour - timeInput.hour;
    date = "$date hours ago";
  } else if (DateTime.now().minute - timeInput.minute != 0) {
    date = DateTime.now().minute - timeInput.minute;
    date = "$date minutes ago";
  } else {
    date = DateTime.now().second - timeInput.second;
    date = "$date seconds ago";
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

//----------------------------------------------------------------
Widget appBarA(
    BuildContext context, String title, String title1, bool status, Icon icon) {
  return AppBar(
    leading: new IconButton(
      iconSize: 30.0,
      icon: icon,
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
        onPressed: () {},
      )
    ],
  );
}
