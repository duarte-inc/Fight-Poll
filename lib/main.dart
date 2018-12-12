import 'package:flutter/material.dart';
import 'package:mma_poll/poll-feed.dart';
import 'package:mma_poll/create-poll.dart';
import 'package:mma_poll/notification.dart';
import 'package:mma_poll/settings.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fight Poll',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textController;

  void initState() {
    super.initState();
    this._textController = TextEditingController();
  }

  void dispose() {
    super.dispose();
    this._textController.dispose();
  }

  Widget _notificationBar() {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationCenter(),
          ),
        );
      },
      iconSize: 30.0,
      tooltip: 'notifications',
      icon: FutureBuilder<List<NotificationModel>>(
        future: getNotifications(1),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Icon(Icons.notifications_none);
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Icon(Icons.notifications_none);
              } else if (snapshot.hasData) {
                if (snapshot.data.length < 1) {
                  return Icon(Icons.notifications_none);
                } else {
                  return Stack(
                    children: <Widget>[
                      Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                      Positioned(
                        right: 0.0,
                        top: 0.0,
                        child: Container(
                          height: 14.0,
                          width: 14.0,
                          child: Text(
                            "${snapshot.data.length}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.0),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  );
                }
              }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: this._notificationBar(),
        title: TextField(
          controller: this._textController,
          autocorrect: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: 15.0),
            isDense: true,
          ),
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            decoration: TextDecoration.none,
          ),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 30.0,
            tooltip: 'settings',
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          )
        ],
      ),
      body: Feed(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePoll(),
            ),
          );
        },
        tooltip: 'create poll',
        child: Icon(Icons.add),
      ),
    );
  }
}
