import 'package:flutter/material.dart';
import 'package:mma_poll/functions.dart';
import 'package:mma_poll/model.dart';
// Notifies when a poll you have created is closed. The thumbnail image in square will be shown
// Also will notify when someone tags you in a comment. Profile image in circle avatar will be displayed

class NotificationCenter extends StatefulWidget {
  @override
  _NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
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
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: pollNotifications.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        print(
                            'navigate to where the comment was made or closed poll');
                      },
                      child: NotificationCard(id: pollNotifications[index].id)),
                  Divider(
                    height: 18.0,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final int id;
  NotificationCard({this.id});
  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  String pic, name1, name2, date;

  @override
  void initState() {
    super.initState();
    this.initInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Poll closings
  void initInfo() {
    for (int i = 0; i < pollNotifications.length; i++) {
      InfoNotification notification = pollNotifications[i];
      if (widget.id == notification.id) {
        this.date = dateFormaterA(notification.date);
        int infoId = notification.infoId;
        for (int j = 0; j < infos.length; j++) {
          Info info = infos[j];
          if (infoId == info.id) {
            this.name1 = info.name1;
            this.name2 = info.name2;
            this.pic = info.pic;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: ListTile(
        isThreeLine:
            false, //will be managed based on replies vs closed poll noti
        leading: new CircleAvatar(
          backgroundImage: new NetworkImage(pic),
          backgroundColor: Colors.grey,
          radius: 28.0,
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '$name1',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' vs ',
              ),
              TextSpan(
                text: '$name2',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' poll has closed.'),
            ],
          ),
        ),
        subtitle: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black45,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'You\'ve picked ',
              ),
              TextSpan(
                text: '$name1',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' $date ago',
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_right,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
