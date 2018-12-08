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
        color: Colors.white,
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
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
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
  bool _isComment;
  String _createdDate;

  @override
  void initState() {
    super.initState();
    this._message = widget.notification.message;
    this._isRead = widget.notification.isRead;
    this._createdDate = widget.notification.createdDate;
    this._account = getNotificationUser(widget.notification.fromUserId);
    this._isComment = widget.notification.isComment;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.all(0.0),
      child: FutureBuilder<AccountModel>(
        future: this._account,
        builder: (BuildContext context, AsyncSnapshot<AccountModel> snapshot) {
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
                return Card(
                  elevation: 0.0,
                  margin: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          this._isComment
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 10.0,
                                      right: 10.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data.profileImage),
                                    radius: 25.0,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 10.0,
                                      right: 10.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    child:
                                        Image.asset('assets/images/poll1.png'),
                                    radius: 25.0,
                                  ),
                                ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                this._isComment
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            text: '',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '${snapshot.data.username}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(text: ' replied to ur comment'),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'poll closed',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${this._message}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${dateFormaterA(this._createdDate)} ago',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
