import 'package:flutter/material.dart';
import 'package:mma_poll/functions.dart';
import 'package:mma_poll/database.dart';
import 'package:mma_poll/model.dart';

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
      body: Stack(
        children: <Widget>[
          Container(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return CommentCard(
                  comment: comments[index],
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
                          hintStyle: TextStyle(
                            fontSize: 13.0
                          ),
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

class CommentCard extends StatefulWidget {
  final Comment comment;

  CommentCard({this.comment});

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  String comment, avatar, username, date, likes;

  String _getAvatar() {
    for (int i = 0; i < comments.length; i++) {
      Comment comment = comments[i];
      if (widget.comment.id == comment.id) {
        for (int j = 0; j < users.length; j++) {
          User user = users[j];
          if (comment.userId == user.id) {
            String userPic = users[j].pic;
            return userPic;
          }
        }
      }
    }
    return null;
  }

  String _getDate() {
    return dateFormaterA(widget.comment.date);
  }

  String _getLikes() {
    return viewRounderA(widget.comment.likes);
  }

  String _getUsername() {
    for (int i = 0; i < comments.length; i++) {
      Comment comment = comments[i];
      if (widget.comment.id == comment.id) {
        for (int j = 0; j < users.length; j++) {
          User user = users[j];
          if (comment.userId == user.id) {
            String username = users[j].username;
            return username;
          }
        }
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    this.avatar = this._getAvatar();
    this.username = this._getUsername();
    this.date = this._getDate();
    this.comment = widget.comment.comment;
    this.likes = this._getLikes();
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
                        backgroundImage: NetworkImage(avatar),
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
                              "${this.username}",
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
                              "${this.date}",
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
                        "${this.comment}",
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
                                "${this.likes}",
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
