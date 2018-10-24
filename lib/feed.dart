import 'package:flutter/material.dart';
import 'package:mma_poll/database.dart';
import 'package:mma_poll/card.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[50],
      child: polls == null
          ? Container(
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
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: 5.0),
              itemCount: polls.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    FightCard(
                      poll: polls[index],
                    ),
                  ],
                );
              },
            ),
    );
  }
}
