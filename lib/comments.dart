import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
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
        child: Text("Comments "),
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
    return Scaffold(
      appBar: this._appBar(),
      body: Container(
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return CommentCard();
          },
        ),
      ),
    );
  }
}

class CommentCard extends StatefulWidget {
  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    const double pad = 15.0;
    return Container(
      child: Card(
        elevation: 0.0,
        margin:
            const EdgeInsets.only(top: 0.0, left: pad, right: pad, bottom: 0.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: pad),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://pbs.twimg.com/profile_images/762515266525761536/HHvPiuIl.jpg"),
                          radius: 25.0,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: pad, right: pad, top: pad),
                              child: Text(
                                "Justine Beiber",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: pad),
                              child: Text(
                                "2 hours ago",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      left: 67.0, top: 2.0, bottom: 6.0, right: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Oaks have spirally arranged leaves, with lobate margins in many species; some have serrated leaves or entire leaves with smooth margins. Many deciduous species are marcescent, not dropping dead leaves until spring. In spring, a single oak tree produces both male flowers (in the form of catkins) and small female flowers",
                        style: TextStyle(
                          fontSize: 15.5,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(0.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                "234",
                                style: TextStyle(),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.thumb_up),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.thumb_down),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Reply",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.orange[900],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
