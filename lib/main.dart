import 'package:flutter/material.dart';
import 'package:mma_poll/poll-feed.dart';
import 'package:mma_poll/create-poll.dart';
import 'package:mma_poll/notification.dart';
import 'package:mma_poll/settings.dart';

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
  TextEditingController textController;

  void initState() {
    super.initState();
    this.textController = new TextEditingController();
  }

  void dispose() {
    super.dispose();
    this.textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.notifications_none),
          tooltip: 'notifications',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationCenter(),
              ),
            );
          },
        ),
        title: TextField(
          controller: this.textController,
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
