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
  Future<CheckModel> _checker;

  Notifier _notifier, _lastNotifier;
  int _votesForFighter1,
      _votesForFighter2,
      _votesForDraw,
      _votesForCanceled,
      _total;
  bool _selected, _status;
  double _name1Perc, _name2Perc, _drawPerc, _cancelPerc;

  void _calcPerc() {
    //Calculating percentage
    this._total = this._votesForFighter1 +
        this._votesForFighter2 +
        this._votesForDraw +
        this._votesForCanceled;
    if (_total == 0) {
      this._total = 1;
    }
    this._name1Perc = (this._votesForFighter1 / this._total).abs();
    this._name2Perc = (this._votesForFighter2 / this._total).abs();
    this._drawPerc = (this._votesForDraw / this._total).abs();
    this._cancelPerc = (this._votesForCanceled / this._total).abs();
  }

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
    this._checker = getCheckedVote("3", widget.poll.id);
    this._selected = widget.poll.status;
    this._status = widget.poll.status;
    this._notifier = Notifier.None;

    _votesForFighter1 = widget.poll.votesForFighter1;
    _votesForFighter2 = widget.poll.votesForFighter2;
    _votesForDraw = widget.poll.votesForDraw;
    _votesForCanceled = widget.poll.votesForCanceled;

    this._selectionManager();
    this._calcPerc();

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
                            right: 16.0, left: 16.0, bottom: 12.0, top: 6.0),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  text: '',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'by ',
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    TextSpan(
                                      text: '${snapshot.data.username}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey),
                                    ),
                                  ],
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
                                  //If the status is closed, then show that of the database result
                                  //Do this from the database and not from the frontend
                                  trailing: FutureBuilder<CheckModel>(
                                    future: this._checker,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<CheckModel> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.active:
                                        case ConnectionState.waiting:
                                          return Container();
                                        case ConnectionState.done:
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Sorry, we\'re having issues with our servers'),
                                            );
                                          } else if (snapshot.hasData) {
                                            return Icon(
                                              this._notifier.index ==
                                                          Notifier.Red.index ||
                                                      (this._status == false &&
                                                          Notifier.Red.index ==
                                                              snapshot.data
                                                                  .checked) ||
                                                      snapshot.data.success ==
                                                          true
                                                  ? Icons.check_circle
                                                  : Icons.check_circle_outline,
                                              color: this._notifier.index ==
                                                          Notifier.Red.index ||
                                                      (this._status == false &&
                                                          Notifier.Red.index ==
                                                              snapshot.data
                                                                  .checked) ||
                                                      snapshot.data.success ==
                                                          true
                                                  ? Colors.red[300]
                                                  : Colors.black45,
                                            );
                                          }
                                      }
                                    },
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
                                      this._selectionManager();
                                      this._calcPerc();
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
                                            (MediaQuery.of(context).size.width -
                                                    32.0) *
                                                this._name1Perc,
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
                                  trailing: FutureBuilder<CheckModel>(
                                    future: this._checker,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<CheckModel> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.active:
                                        case ConnectionState.waiting:
                                          return Container();
                                        case ConnectionState.done:
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Sorry, we\'re having issues with our servers'),
                                            );
                                          } else if (snapshot.hasData) {
                                            return Icon(
                                              this._notifier.index ==
                                                          Notifier
                                                              .Yellow.index ||
                                                      (this._status == false &&
                                                          Notifier.Yellow
                                                                  .index ==
                                                              snapshot.data
                                                                  .checked) ||
                                                      snapshot.data.success ==
                                                          true
                                                  ? Icons.check_circle
                                                  : Icons.check_circle_outline,
                                              color: this._notifier.index ==
                                                          Notifier
                                                              .Yellow.index ||
                                                      (this._status == false &&
                                                          Notifier.Yellow
                                                                  .index ==
                                                              snapshot.data
                                                                  .checked) ||
                                                      snapshot.data.success ==
                                                          true
                                                  ? Colors.red[300]
                                                  : Colors.black45,
                                            );
                                          }
                                      }
                                    },
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
                                      this._selectionManager();
                                      this._calcPerc();
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
                                            (MediaQuery.of(context).size.width -
                                                    32.0) *
                                                this._name2Perc,
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
                                  trailing: FutureBuilder<CheckModel>(
                                    future: this._checker,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<CheckModel> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.active:
                                        case ConnectionState.waiting:
                                          return Container();
                                        case ConnectionState.done:
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Sorry, we\'re having issues with our servers'),
                                            );
                                          } else if (snapshot.hasData) {
                                            return Icon(
                                              this._notifier.index ==
                                                          Notifier.Blue.index ||
                                                      (this._status == false &&
                                                          Notifier.Blue.index ==
                                                              snapshot.data
                                                                  .checked) ||
                                                      snapshot.data.success ==
                                                          true
                                                  ? Icons.check_circle
                                                  : Icons.check_circle_outline,
                                              color: this._notifier.index ==
                                                          Notifier.Blue.index ||
                                                      (this._status == false &&
                                                          Notifier.Blue.index ==
                                                              snapshot.data
                                                                  .checked) ||
                                                      snapshot.data.success ==
                                                          true
                                                  ? Colors.red[300]
                                                  : Colors.black45,
                                            );
                                          }
                                      }
                                    },
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
                                      this._selectionManager();
                                      this._calcPerc();
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
                                            (MediaQuery.of(context).size.width -
                                                    32.0) *
                                                this._drawPerc,
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
                                  trailing: FutureBuilder<CheckModel>(
                                    future: this._checker,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<CheckModel> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.active:
                                        case ConnectionState.waiting:
                                          return Container();
                                        case ConnectionState.done:
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Sorry, we\'re having issues with our servers'),
                                            );
                                          } else if (snapshot.hasData) {
                                            return Icon(
                                              this._notifier.index ==
                                                          Notifier
                                                              .Green.index ||
                                                      (this._status == false &&
                                                          Notifier.Green
                                                                  .index ==
                                                              snapshot.data
                                                                  .checked) ||
                                                      snapshot.data.success ==
                                                          true
                                                  ? Icons.check_circle
                                                  : Icons.check_circle_outline,
                                              color: this._notifier.index ==
                                                          Notifier
                                                              .Green.index ||
                                                      (this._status == false &&
                                                          Notifier.Green
                                                                  .index ==
                                                              snapshot.data
                                                                  .checked) ||
                                                      snapshot.data.success ==
                                                          true
                                                  ? Colors.red[300]
                                                  : Colors.black45,
                                            );
                                          }
                                      }
                                    },
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
                                      this._selectionManager();
                                      this._calcPerc();
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
                                            (MediaQuery.of(context).size.width -
                                                    32.0) *
                                                this._cancelPerc,
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
