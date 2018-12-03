import 'package:flutter/material.dart';
import 'package:mma_poll/comments.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/animation.dart';
import 'package:mma_poll/functions.dart';

enum Notifier {
  Red,
  Yellow,
  Blue,
  Green,
  None,
}

class Poll extends StatefulWidget {
  final int id;

  //Constructor
  Poll(this.id);

  @override
  _PollState createState() => _PollState();
}

class _PollState extends State<Poll> {
  //class level widgets
  FightPoll poll;
  Info info;
  Notifier notifier, lastNotifier;
  Color color;

  //class level ints
  int name1Num, name2Num, drawNum, cancelNum;

  //class level bools
  bool redSelected, blueSelected, greenSelected, yellowSelected;
  bool selected;

  Info _info() {
    for (int i = 0; i < infos.length; i++) {
      Info info = infos[i];
      if (info.id == widget.id) {
        return info;
      }
    }
    return null;
  }

  FightPoll _poll() {
    for (int i = 0; i < infos.length; i++) {
      Info info = infos[i];
      if (info.id == widget.id) {
        for (int j = 0; j < polls.length; j++) {
          FightPoll poll = polls[j];
          if (poll.id == info.pollId) {
            return poll;
          }
        }
      }
    }
    return null;
  }

  void _selectionManager() {
    if (this.notifier == Notifier.Red) {
      this.name1Num++;
    } else if (this.notifier == Notifier.Yellow) {
      this.name2Num++;
    } else if (this.notifier == Notifier.Blue) {
      this.drawNum++;
    } else if (this.notifier == Notifier.Green) {
      this.cancelNum++;
    }
    if (this.lastNotifier == Notifier.Red) {
      this.name1Num--;
    } else if (this.lastNotifier == Notifier.Yellow) {
      this.name2Num--;
    } else if (this.lastNotifier == Notifier.Blue) {
      this.drawNum--;
    } else if (this.lastNotifier == Notifier.Green) {
      this.cancelNum--;
    }
  }

  @override
  void initState() {
    super.initState();
    this.poll = this._poll();
    this.info = this._info();
    this.notifier = Notifier.None;
    this.lastNotifier = Notifier.None;

    // selected a poll?
    this.selected = info.status;

    //numbers
    this.name1Num = this.poll.name1Num;
    this.name2Num = this.poll.name2Num;
    this.drawNum = this.poll.drawNum;
    this.cancelNum = this.poll.canceledNum;
  }

  @override
  void didUpdateWidget(Poll oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //This manages selection of choices

    this._selectionManager();

    //Calculating percentage

    int total = this.name1Num + this.name2Num + this.drawNum + this.cancelNum;
    double name1Perc = this.name1Num / total;
    double name2Perc = this.name2Num / total;
    double drawPerc = this.drawNum / total;
    double cancelPerc = this.cancelNum / total;
    return Scaffold(
      appBar: appBarAll(
        context,
        "Vote",
        "View Poll",
        this.info.status,
      ),
      body: SingleChildScrollView(
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
              "${this.info.title}",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 12.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "Poller: Thomas",
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "${dateFormaterA(this.info.postedDate)} ago",
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
            padding:
                EdgeInsets.only(top: 0.0, bottom: 0.0, right: 10.0, left: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                this.info.pic,
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
                        "${this.info.name1}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      subtitle: Text(
                        "$name1Num",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      enabled: this.info.status,
                      trailing: Icon(
                        this.notifier == Notifier.Red
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: this.notifier == Notifier.Red
                            ? Colors.red[200]
                            : Colors.black45,
                      ),
                      onTap: () {
                        setState(() {
                          this.selected = false;
                          this.lastNotifier = this.notifier;
                          if (this.notifier == Notifier.Red) {
                            return;
                          } else if (this.notifier != Notifier.Red) {
                            this.notifier = Notifier.Red;
                          }
                        });
                      },
                    ),
                  ),
                  this.selected
                      ? Container()
                      : SizeAnimation(
                          child: Container(
                            color: Colors.yellow[700],
                            width:
                                MediaQuery.of(context).size.width * name1Perc,
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
                        "${this.info.name2}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      subtitle: Text(
                        "$name2Num",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      enabled: this.info.status,
                      trailing: Icon(
                        this.notifier == Notifier.Yellow
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: this.notifier == Notifier.Yellow
                            ? Colors.red[300]
                            : Colors.black45,
                      ),
                      onTap: () {
                        this.selected = false;
                        this.lastNotifier = this.notifier;
                        setState(() {
                          if (this.notifier == Notifier.Yellow) {
                            return;
                          } else if (this.notifier != Notifier.Yellow) {
                            this.notifier = Notifier.Yellow;
                          }
                        });
                      },
                    ),
                  ),
                  this.selected
                      ? Container()
                      : SizeAnimation(
                          child: Container(
                            color: Colors.green,
                            width:
                                MediaQuery.of(context).size.width * name2Perc,
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
                        "$drawNum",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      enabled: this.info.status,
                      trailing: Icon(
                        this.notifier == Notifier.Blue
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: this.notifier == Notifier.Blue
                            ? Colors.red[300]
                            : Colors.black45,
                      ),
                      onTap: () {
                        setState(() {
                          this.selected = false;
                          this.lastNotifier = this.notifier;
                          if (this.notifier == Notifier.Blue) {
                            return;
                          } else if (this.notifier != Notifier.Blue) {
                            this.notifier = Notifier.Blue;
                          }
                        });
                      },
                    ),
                  ),
                  this.selected
                      ? Container()
                      : SizeAnimation(
                          child: Container(
                            color: Colors.blue,
                            width: MediaQuery.of(context).size.width * drawPerc,
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
                        "$cancelNum",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      enabled: this.info.status,
                      trailing: Icon(
                        this.notifier == Notifier.Green
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: this.notifier == Notifier.Green
                            ? Colors.red[200]
                            : Colors.black45,
                      ),
                      onTap: () {
                        setState(() {
                          this.selected = false;
                          this.lastNotifier = this.notifier;
                          if (this.notifier == Notifier.Green) {
                            return;
                          } else if (this.notifier != Notifier.Green) {
                            this.notifier = Notifier.Green;
                          }
                        });
                      },
                    ),
                  ),
                  this.selected
                      ? Container()
                      : SizeAnimation(
                          child: Container(
                            color: Colors.black87,
                            width:
                                MediaQuery.of(context).size.width * cancelPerc,
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
                    decoration: TextDecoration.combine([TextDecoration.none])),
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
      ),
    );
  }
}
