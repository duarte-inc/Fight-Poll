import 'package:flutter/material.dart';
import 'package:mma_poll/functions.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/_service.dart';

class Comments extends StatefulWidget {
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //BuildContext context, String title, String title1, bool status, Icon icon
        appBar: appBarAll(
          context,
          "Comments ",
          "",
          true,
        ),
        body: Container(
          color: Colors.yellow[50],
          child: FutureBuilder<List<CommentModel>>(
            future: getParentComments(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CommentModel>> snapshot) {
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
                      child:
                          Text("Sorry, we are having issues with our servers"),
                    );
                  } else if (snapshot.hasData) {
                    //Todo
                    return Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return CommentCard(
                                  comment: snapshot.data[index],
                                );
                              },
                            ),
                          ),
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            bottom: 0.0,
                            child: Material(
                              elevation: 5.0,
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextField(
                                        // maxLines: 50,
                                        maxLengthEnforced: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'comment...',
                                          hintStyle: TextStyle(fontSize: 13.0),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.send,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              }
            },
          ),
        ));
  }
}

class CommentCard extends StatefulWidget {
  final CommentModel comment;

  CommentCard({this.comment});

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  int _likes;
  String _info;
  DateTime _cratedDate;
  AccountModel _account;

  @override
  void initState() {
    super.initState();
    this._likes = widget.comment.likes;
    this._info = widget.comment.info;
    this._cratedDate = widget.comment.createdDate;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double pad = 10.0;
    return Container(
      child: Card(
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: pad),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(this._account.profileImage),
                        radius: 20.0,
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
                              "${this._account.username}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: pad),
                            child: Text(
                              "${this._cratedDate}",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 13.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      left: 51.0, top: 3.0, bottom: 0.0, right: 0.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "${this._info}",
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.07,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 6.0),
                              child: Text(
                                "${this._likes}",
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
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  onPressed: () {
                                    print("reply");
                                  },
                                  child: Text(
                                    "Reply",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.orange[900],
                                    ),
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
