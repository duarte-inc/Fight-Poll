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
      appBar: appBarA(
        context,
        "Comments ",
        "",
        true,
        Icon(Icons.arrow_back),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return CommentCard(
              comment: comments[index],
            );
          },
        ),
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
                          backgroundImage: NetworkImage(avatar),
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
                                "${this.username}",
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
                                "${this.date}",
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
                      left: 66.0, top: 2.0, bottom: 0.0, right: 6.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "${this.comment}",
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
