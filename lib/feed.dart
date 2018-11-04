import 'package:flutter/material.dart';
import 'package:mma_poll/database.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/poll.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[50],
      child: infos == null
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
              itemCount: infos.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    FightCard(
                      infos: infos[index],
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class FightCard extends StatefulWidget {
  final Info infos;

  FightCard({this.infos});

  @override
  _FightCardState createState() => _FightCardState();
}

class _FightCardState extends State<FightCard> {
  bool status;
  String name1, name2;
  FightPoll poll;

  @override
  void initState() {
    super.initState();
    //bool
    this.status = widget.infos.status;
    //string
    this.name1 = widget.infos.name1;
    this.name2 = widget.infos.name2;
    //poll
    this.poll = this._getPoll();
  }

  FightPoll _getPoll() {
    for (int i = 0; i < polls.length; i++) {
      FightPoll poll = polls[i];
      if (poll.id == widget.infos.pollId) {
        return poll;
      }
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _cardInfo() {
    int name1Num = this.poll.name1Num;
    int name2Num = this.poll.name2Num;
    int drawNum = this.poll.drawNum;
    int canceledNum = this.poll.canceledNum;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: 7.0,
            left: 20.0,
          ),
          child: Text(
            widget.infos.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.2,
            ),
          ),
        ),
        Divider(
          height: 0.5,
          color: Colors.grey[300],
          indent: 23.0,
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(children: <Widget>[
                  Text(
                    "Poll Count:",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
              Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      "Draw",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text(
                    "$drawNum",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
              Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      "$name1",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text(
                    "$name1Num",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
              Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      "$name2",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text(
                    "$name2Num",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
              Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      "Canceled",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text(
                    "$canceledNum",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Poll(
                    widget.infos.id,
                  ),
            ),
          );
          super.setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1.5,
                spreadRadius: 2.0,
              ),
            ],
          ),
          height: 175.0,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Material(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    widget.infos.pic,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.35),
                            Colors.black.withOpacity(0.79)
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      color: Colors.black,
                                      child: Text(
                                        status ? "Open" : "Closed",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: 50.0, left: 0.0, right: 20.0),
                                    alignment: Alignment.topLeft,
                                    width: MediaQuery.of(context).size.width,
                                    child: this._cardInfo()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
