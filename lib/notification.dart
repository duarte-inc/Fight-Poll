import 'package:flutter/material.dart';

// Notifies when a poll you have created is closed. The thumbnail image in square will be shown
// Also will notify when someone tags you in a comment. Profile image in circle avatar will be displayed

class NotificationCenter extends StatefulWidget {
  @override
  _NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  Widget _appBar() {
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
        child: Text("Notification "),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._appBar(),
      body: Container(
        margin: EdgeInsets.only(top: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Column(children: <Widget>[
                Card(
                  elevation: 0.0,
                  child: ListTile(
                    isThreeLine:
                        false, //will be managed based on replies vs closed poll noti
                    leading: new CircleAvatar(
                      backgroundImage: new NetworkImage(
                          "https://static1.squarespace.com/static/56a44a68cbced66ef85f1331/56a8cc40df40f3b3891c89a0/56a8d60fa976afa6650bc5e5/1453906043205/MIKE+TYSON.jpg"),
                      backgroundColor: Colors.grey,
                      radius: 28.0,
                    ),
                    title: Text(
                      'Eddie vs Conor Poll is closed!',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    subtitle: Text('You have selected Eddie 2 hours ago '),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                        ),
                        onPressed: () {}),
                  ),
                ),
                Divider(
                  height: 18.0,
                  color: Colors.grey[300],
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
