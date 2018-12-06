import 'package:flutter/material.dart';
import 'package:mma_poll/functions.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/_service.dart';
// Notifies when a poll you have created is closed. The thumbnail image in square will be shown
// Also will notify when someone tags you in a comment. Profile image in circle avatar will be displayed

class NotificationCenter extends StatefulWidget {
  @override
  _NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAll(
        context,
        "Notifications",
        "",
        true,
      ),
      body: Container(
        color: Colors.yellow[50],
        child: FutureBuilder<List<NotificationModel>>(
          future: getNotifications(1),
          builder: (BuildContext context,
              AsyncSnapshot<List<NotificationModel>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Container(
                  color: Colors.yellow[50],
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    padding: EdgeInsets.all(30.0),
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Sorry, we are having issues with our servers"),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 5.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          NotificationCard(
                            notification: snapshot.data[index],
                          ),
                        ],
                      );
                    },
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;
  NotificationCard({this.notification});
  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  String _message;
  Future<AccountModel> _account;
  bool _isRead;
  String _createdDate;

  @override
  void initState() {
    super.initState();
    this._message = widget.notification.message;
    this._isRead = widget.notification.isRead;
    this._createdDate = widget.notification.createdDate;
    this._account = getNotificationUser(1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<AccountModel>(
        future: this._account,
        builder: (BuildContext context, AsyncSnapshot<AccountModel> snapshot) {
          if (snapshot.data != null) {
            print('helellelelelele');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return new CircleAvatar(
                backgroundImage: null,
                backgroundColor: Colors.grey,
                radius: 28.0,
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Sorry, we are having issues with our servers"),
                );
              } else if (snapshot.hasData) {
                return Container(
                  width: 40.0,
                  height: 40.0,
                  color: Colors.black,
                );
              }
          }
        },
      ),
    );
  }
}
