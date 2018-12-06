import 'package:flutter/material.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/poll.dart';
import 'package:mma_poll/_service.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
    super.initState();
    getPolls().then((j) {
      print(j);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[50],
      child: FutureBuilder<List<PollModel>>(
        future: getPolls(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PollModel>> snapshot) {
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
                print(snapshot.error);
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
                        FightCard(
                          poll: snapshot.data[index],
                        ),
                      ],
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}

class FightCard extends StatefulWidget {
  final PollModel poll;

  FightCard({this.poll});

  @override
  _FightCardState createState() => _FightCardState();
}

class _FightCardState extends State<FightCard> {
  int _votesForFighter1, _votesForFighter2, _votesForDraw, _votesForCanceled;
  bool _status;
  String _title, _fighter1, _fighter2, _image;

  @override
  void initState() {
    super.initState();
    this._status = widget.poll.status;
    this._title = widget.poll.title;
    this._fighter1 = widget.poll.fighter1;
    this._fighter2 = widget.poll.fighter2;
    this._votesForFighter1 = widget.poll.votesForFighter1;
    this._votesForFighter2 = widget.poll.votesForFighter2;
    this._votesForDraw = widget.poll.votesForDraw;
    this._votesForCanceled = widget.poll.votesForCanceled;
    this._image = widget.poll.image;
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
            _title,
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
                    "$_votesForDraw",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
              Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      "$_fighter1",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text(
                    "$_votesForFighter1",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
              Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      "$_fighter2",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text(
                    "$_votesForFighter2",
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
                    "$_votesForCanceled",
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
                    _image,
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
                                        _status ? "Open" : "Closed",
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
