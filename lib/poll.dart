import 'package:flutter/material.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/database.dart';

class Poll extends StatefulWidget {
  final int id;

  //Constructor
  Poll(this.id);

  @override
  _PollState createState() => _PollState();
}

class _PollState extends State<Poll> {
  FightPoll poll;
  FightInfo info;

  @override
  void initState() {
    super.initState();
    this.poll = this._poll();
    this.info = this._info();
  }

  FightInfo _info() {
    for (int i = 0; i < infos.length; i++) {
      FightInfo info = infos[i];
      if (info.id == widget.id) {
        return info;
      }
    }
    return null;
  }

  FightPoll _poll() {
    for (int i = 0; i < infos.length; i++) {
      FightInfo info = infos[i];
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

  String _dateFormater(DateTime d) {
    dynamic date;
    if (DateTime.now().year - d.year != 0) {
      date = DateTime.now().year - d.year;
      date = "$date y ago";
    } else if (DateTime.now().month - d.month != 0) {
      date = (DateTime.now().month - d.month).abs();
      date = "$date mnz ago";
    } else if (DateTime.now().day - d.day != 0) {
      date = DateTime.now().day - d.day;
      date = "$date d ago";
    } else if (DateTime.now().hour - d.hour != 0) {
      date = DateTime.now().hour - d.hour;
      date = "$date h ago";
    } else if (DateTime.now().minute - d.minute != 0) {
      date = DateTime.now().minute - d.minute;
      date = "$date min ago";
    } else {
      date = DateTime.now().second - d.second;
      date = "$date s ago";
    }
    return date;
  }

  Widget _appBar() {
    return AppBar(
      leading: new IconButton(
        iconSize: 30.0,
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Container(
        alignment: Alignment.center,
        child: this.info.status
            ? Text(
                "Vote",
                textAlign: TextAlign.center,
                style: TextStyle(),
              )
            : Text(
                "View Poll",
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
      ),
      actions: <Widget>[
        IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.settings),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = this.info.title;
    String name1 = this.info.name1Name;
    String name2 = this.info.name2Name;

    int name1Num = this.poll.name1Num;
    int name2Num = this.poll.name2Num;
    int drawNum = this.poll.drawNum;
    int cancelNum = this.poll.canceledNum;

    String date = this._dateFormater(this.info.postedDate);

    return Scaffold(
      appBar: this._appBar(),
      body: Container(
        padding: EdgeInsets.only(right: 15.0),
        color: Colors.white,
        child: Column(children: <Widget>[
          Container(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 3.0, bottom: 3.0, left: 0.0, right: 0.0),
              child: Container(
                padding: EdgeInsets.all(0.0),
                child: ListTile(
                  title: Text(
                    "$title",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Poller: Thomas",
                  ),
                  enabled: true,
                  trailing: Text("$date"),
                  onTap: () {},
                ),
              ),
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
              Container(
                color: Colors.red[200],
                child: ListTile(
                  title: Text(
                    "$name1",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  subtitle: Text(
                    "$name1Num",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  enabled: this.info.status,
                  trailing: Icon(Icons.check_circle_outline),
                  onTap: () {},
                ),
              ),
              Container(
                color: Colors.yellow[200],
                child: ListTile(
                  title: Text(
                    "$name2",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  subtitle: Text(
                    "$name2Num",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  enabled: this.info.status,
                  trailing: Icon(Icons.check_circle_outline),
                  onTap: () {},
                ),
              ),
              Container(
                color: Colors.blue[200],
                child: ListTile(
                  title: const Text(
                    "Draw",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  subtitle: Text(
                    "$drawNum",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  enabled: this.info.status,
                  trailing: Icon(Icons.check_circle_outline),
                  onTap: () {},
                ),
              ),
              Container(
                padding: EdgeInsets.all(0.0),
                color: Colors.green[200],
                child: ListTile(
                  title: const Text(
                    "Canceled",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  subtitle: Text(
                    "$cancelNum",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  enabled: this.info.status,
                  trailing: Icon(Icons.check_circle_outline),
                  onTap: () {},
                ),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              "View Comments [23]",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  decoration:
                      TextDecoration.combine([TextDecoration.underline])),
            ),
          ),
        ]),
      ),
    );
  }
}
