import 'package:flutter/material.dart';
import 'package:mma_poll/functions.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/_service.dart';
import 'package:mma_poll/account.dart';

class Comments extends StatefulWidget {
  final int pollId;
  Comments({this.pollId});
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  Future<List<CommentModel>> _comments;
  Key _key;
  TextEditingController _textEditingController;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    this._comments = getParentComments(widget.pollId);
    this._textEditingController = TextEditingController();
    this._key = GlobalKey();
  }

  @override
  void didUpdateWidget(Comments oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    this._textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAll(
        context,
        "Comments ",
        "",
        true,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<CommentModel>>(
          future: this._comments,
          builder: (BuildContext context,
              AsyncSnapshot<List<CommentModel>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Container(
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
                  //Todo
                  return Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 12.0),
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
                                      focusNode: this._focusNode,
                                      controller: this._textEditingController,
                                      key: this._key,
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
                                      onPressed: () {
                                        print('commment submited');
                                      },
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
      ),
    );
  }
}

class CommentCard extends StatefulWidget {
  final CommentModel comment;

  CommentCard({this.comment});

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  Future<AccountModel> _account;

  @override
  void initState() {
    super.initState();
    this._account = getUser(widget.comment.creatorId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double pad = 10.0;
    return Container(
      child: FutureBuilder<AccountModel>(
        future: this._account,
        builder: (BuildContext context, AsyncSnapshot<AccountModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container();
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Sorry, we're having issues with our servers"),
                );
              } else if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () {
                    print('comment tapped');
                  },
                  child: Card(
                    elevation: 0.0,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              //the file is changed
                              padding: EdgeInsets.only(top: pad),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data.profileImage),
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ViewProfile(
                                                  userId: int.parse(
                                                      snapshot.data.id),
                                                ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "${snapshot.data.username}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: pad),
                                    child: Text(
                                      "${dateFormaterA(widget.comment.createdDate)}",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13.0),
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
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${widget.comment.info}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    height: 1.07,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.zero,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: pad / 2),
                                      child: Text(
                                        "${widget.comment.likes}",
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
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            left: 35.0,
                            top: 0.0,
                            bottom: 0.0,
                            right: 0.0,
                          ),
                          child: Replies(),
                        ),
                        Container(height: pad,)
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

//REPLY

class Replies extends StatefulWidget {
  final int parentCommentId;
  final int pollId;
  Replies({this.parentCommentId, this.pollId});

  @override
  _RepliesState createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  Future<List<CommentModel>> _replies;

  @override
  void initState() {
    super.initState();
    this._replies = getReplies(1, 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<CommentModel>>(
        future: this._replies,
        builder:
            (BuildContext context, AsyncSnapshot<List<CommentModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
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
                //Todo
                return Container(
                  height: snapshot.data.length * 120.0,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ReplyCard(
                        reply: snapshot.data[index],
                      );
                    },
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

//reply card
class ReplyCard extends StatefulWidget {
  final CommentModel reply;
  ReplyCard({this.reply});
  @override
  _ReplyCardState createState() => _ReplyCardState();
}

class _ReplyCardState extends State<ReplyCard> {
  Future<AccountModel> _account;
  @override
  void initState() {
    this._account = getUser(widget.reply.creatorId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double pad = 10.0;
    return Container(
      child: FutureBuilder<AccountModel>(
        future: this._account,
        builder: (BuildContext context, AsyncSnapshot<AccountModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container();
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Sorry, we're having issues with our servers"),
                );
              } else if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () {
                    print('comment tapped');
                  },
                  child: Card(
                    elevation: 0.0,
                    margin: const EdgeInsets.only(left: pad),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              //the file is changed
                              padding: EdgeInsets.only(top: pad),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data.profileImage),
                                radius: 18.0,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: pad, right: pad, top: pad),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ViewProfile(
                                                  userId: int.parse(
                                                      snapshot.data.id),
                                                ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "${snapshot.data.username}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: pad),
                                    child: Text(
                                      "${dateFormaterA(widget.reply.createdDate)}",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),//51.0, top: 3.0, bottom: 0.0, right: 0.0)
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: 46.0, top: 3.0, bottom: 0.0, right: 0.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${widget.reply.info}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    height: 1.07,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.zero,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: pad/2),
                                      child: Text(
                                        "${widget.reply.likes}",
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
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
