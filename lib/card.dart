import 'package:flutter/material.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/poll.dart';

class FightCard extends StatefulWidget {
  final FightPoll poll;

  FightCard({this.poll});

  @override
  _FightCardState createState() => _FightCardState();
}

class _FightCardState extends State<FightCard> {
  int draw, name1Num, name2Num, canceled;
  bool status;
  String name1, name2;

  @override
  void initState() {
    super.initState();
    //int
    this.draw = widget.poll.drawNum;
    this.name1Num = widget.poll.name1Num;
    this.name2Num = widget.poll.name2Num;
    this.canceled = widget.poll.canceledNum;
    //bool
    this.status = widget.poll.status;
    //string
    this.name1 = widget.poll.name1Name;
    this.name2 = widget.poll.name2Name;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _cardInfo() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: 7.0,
            left: 20.0,
          ),
          child: Text(
            widget.poll.title,
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
                    "$draw",
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
                    "$canceled",
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
                    widget.poll.id,
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
              ]),
          height: 170.0,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Material(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    widget.poll.pic,
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
                            Colors.black.withOpacity(0.60)
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
                                        top: 45.0, left: 0.0, right: 20.0),
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
