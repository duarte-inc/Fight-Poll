import 'package:flutter/material.dart';
import 'package:mma_poll/comments.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/_service.dart';
import 'package:mma_poll/animation.dart';
import 'package:mma_poll/settings.dart';
import 'package:mma_poll/functions.dart';

enum Notifier {
  Red,
  Yellow,
  Blue,
  Green,
  None,
}

class Poll extends StatefulWidget {
  final PollModel poll;

  //Constructor
  Poll({this.poll});

  @override
  _PollState createState() => _PollState();
}

class _PollState extends State<Poll> {
  Future<AccountModel> _poller;
  Notifier _notifier, _lastNotifier;
  int _votesForFighter1, _votesForFighter2, _votesForDraw, _votesForCanceled;
  bool _selected, _status;

  void _selectionManager() {
    if (this._notifier == Notifier.Red) {
      this._votesForFighter1++;
    } else if (this._notifier == Notifier.Yellow) {
      this._votesForFighter2++;
    } else if (this._notifier == Notifier.Blue) {
      this._votesForDraw++;
    } else if (this._notifier == Notifier.Green) {
      this._votesForCanceled++;
    }
    if (this._lastNotifier == Notifier.Red) {
      this._votesForFighter1--;
    } else if (this._lastNotifier == Notifier.Yellow) {
      this._votesForFighter2--;
    } else if (this._lastNotifier == Notifier.Blue) {
      this._votesForDraw--;
    } else if (this._lastNotifier == Notifier.Green) {
      this._votesForCanceled--;
    }
  }

  @override
  void initState() {
    super.initState();

    this._poller = viewProfile(widget.poll.creatorId);
    this._selected = widget.poll.status;
    this._status = widget.poll.status;

    _votesForFighter1 = widget.poll.votesForFighter1;
    _votesForFighter2 = widget.poll.votesForFighter2;
    _votesForDraw = widget.poll.votesForDraw;
    _votesForCanceled = widget.poll.votesForCanceled;

    print('initState');
  }

  @override
  void didUpdateWidget(Poll oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdate');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    //This manages selection of choices
    this._selectionManager();

    //Calculating percentage
    int total = this._votesForFighter1 +
        this._votesForFighter2 +
        this._votesForDraw +
        this._votesForCanceled;
    if (total == 0) {
      total = 1;
    }
    double name1Perc = (this._votesForFighter1 / total).abs();
    double name2Perc = (this._votesForFighter2 / total).abs();
    double drawPerc = (this._votesForDraw / total).abs();
    double cancelPerc = (this._votesForCanceled / total).abs();

    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(this._status ? "Vote" : "View poll"),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.settings),
            onPressed: () {
              this._lastNotifier = Notifier.None;
              this._notifier = Notifier.None;
              _votesForFighter1 = widget.poll.votesForFighter1;
              _votesForFighter2 = widget.poll.votesForFighter2;
              _votesForDraw = widget.poll.votesForDraw;
              _votesForCanceled = widget.poll.votesForCanceled;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
            tooltip: 'settings',
          )
        ],
      ),
      body: Container(
        color: Colors.yellow[50],
        child: FutureBuilder<AccountModel>(
          future: this._poller,
          builder:
              (BuildContext context, AsyncSnapshot<AccountModel> snapshot) {
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
                    child: Text("Sorry, we're having issues with our servers"),
                  );
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          right: 16.0,
                          left: 16.0,
                          top: 12.0,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          widget.poll.title,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: 16.0, left: 16.0, bottom: 12.0),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Poller: ${snapshot.data.username}",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${dateFormaterA(widget.poll.createdDate)} ago",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0.0, bottom: 0.0, right: 10.0, left: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            widget.poll.image,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * .28,
                            width: MediaQuery.of(context).size.width * .95,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5.0),
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(children: <Widget>[
                          Stack(
                            fit: StackFit.passthrough,
                            children: <Widget>[
                              Container(
                                color: Colors.yellow[100],
                                child: ListTile(
                                  dense: true,
                                  title: Text(
                                    widget.poll.fighter1,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  subtitle: Text(
                                    "${this._votesForFighter1}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  enabled: widget.poll.status,
                                  trailing: Icon(
                                    this._notifier == Notifier.Red
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: this._notifier == Notifier.Red
                                        ? Colors.red[200]
                                        : Colors.black45,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      this._selected = false;
                                      this._lastNotifier = this._notifier;
                                      if (this._notifier == Notifier.Red) {
                                        return;
                                      } else if (this._notifier !=
                                          Notifier.Red) {
                                        this._notifier = Notifier.Red;
                                      }
                                    });
                                  },
                                ),
                              ),
                              this._selected
                                  ? Container()
                                  : SizeAnimation(
                                      child: Container(
                                        color: Colors.yellow[700],
                                        width:
                                            MediaQuery.of(context).size.width *
                                                name1Perc,
                                        height: 10.0,
                                      ),
                                    ),
                            ],
                          ),
                          Stack(
                            fit: StackFit.passthrough,
                            children: <Widget>[
                              Container(
                                color: Colors.green[100],
                                child: ListTile(
                                  dense: true,
                                  title: Text(
                                    widget.poll.fighter2,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  subtitle: Text(
                                    "${this._votesForFighter2}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  enabled: widget.poll.status,
                                  trailing: Icon(
                                    this._notifier == Notifier.Yellow
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: this._notifier == Notifier.Yellow
                                        ? Colors.red[300]
                                        : Colors.black45,
                                  ),
                                  onTap: () {
                                    this._selected = false;
                                    this._lastNotifier = this._notifier;
                                    setState(() {
                                      if (this._notifier == Notifier.Yellow) {
                                        return;
                                      } else if (this._notifier !=
                                          Notifier.Yellow) {
                                        this._notifier = Notifier.Yellow;
                                      }
                                    });
                                  },
                                ),
                              ),
                              this._selected
                                  ? Container()
                                  : SizeAnimation(
                                      child: Container(
                                        color: Colors.green,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                name2Perc,
                                        height: 10.0,
                                      ),
                                    ),
                            ],
                          ),
                          Stack(
                            fit: StackFit.passthrough,
                            children: <Widget>[
                              Container(
                                color: Colors.blue[100],
                                child: ListTile(
                                  dense: true,
                                  title: const Text(
                                    "Draw",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  subtitle: Text(
                                    "${this._votesForDraw}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  enabled: widget.poll.status,
                                  trailing: Icon(
                                    this._notifier == Notifier.Blue
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: this._notifier == Notifier.Blue
                                        ? Colors.red[300]
                                        : Colors.black45,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      this._selected = false;
                                      this._lastNotifier = this._notifier;
                                      if (this._notifier == Notifier.Blue) {
                                        return;
                                      } else if (this._notifier !=
                                          Notifier.Blue) {
                                        this._notifier = Notifier.Blue;
                                      }
                                    });
                                  },
                                ),
                              ),
                              this._selected
                                  ? Container()
                                  : SizeAnimation(
                                      child: Container(
                                        color: Colors.blue,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                drawPerc,
                                        height: 10.0,
                                      ),
                                    ),
                            ],
                          ),
                          Stack(
                            fit: StackFit.passthrough,
                            children: <Widget>[
                              Container(
                                color: Colors.grey[100],
                                child: ListTile(
                                  dense: true,
                                  title: const Text(
                                    "Canceled",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  subtitle: Text(
                                    "${this._votesForCanceled}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  enabled: widget.poll.status,
                                  trailing: Icon(
                                    this._notifier == Notifier.Green
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: this._notifier == Notifier.Green
                                        ? Colors.red[200]
                                        : Colors.black45,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      this._selected = false;
                                      this._lastNotifier = this._notifier;
                                      if (this._notifier == Notifier.Green) {
                                        return;
                                      } else if (this._notifier !=
                                          Notifier.Green) {
                                        this._notifier = Notifier.Green;
                                      }
                                    });
                                  },
                                ),
                              ),
                              this._selected
                                  ? Container()
                                  : SizeAnimation(
                                      child: Container(
                                        color: Colors.black87,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                cancelPerc,
                                        height: 10.0,
                                      ),
                                    ),
                            ],
                          ),
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: GestureDetector(
                          child: Text(
                            "View Comments [23]",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                decoration: TextDecoration.combine(
                                    [TextDecoration.none])),
                          ),
                          onTap: () {
                            this._notifier = Notifier.None;
                            this._lastNotifier = Notifier.None;
                            _votesForFighter1 = widget.poll.votesForFighter1;
                            _votesForFighter2 = widget.poll.votesForFighter2;
                            _votesForDraw = widget.poll.votesForDraw;
                            _votesForCanceled = widget.poll.votesForCanceled;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Comments(),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
