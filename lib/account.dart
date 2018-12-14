import 'package:flutter/material.dart';
import 'package:mma_poll/functions.dart';
import 'package:mma_poll/model.dart';
import 'package:mma_poll/_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * .05;
    return Scaffold(
      appBar: appBarAll(context, "Sign in", "", true),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "assets/images/poll1.png",
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              bottom: 0.0,
              child: Container(
                padding:
                    EdgeInsets.only(top: topPadding, left: 55.0, right: 55.0),
                decoration:
                    BoxDecoration(color: Colors.yellow[400].withOpacity(0.95)),
                child: Form(
                  child: ListView(children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "username",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "password",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        child: new Text(
                          'Sign in',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        splashColor: Colors.yellow[600],
                        color: Colors.yellow[500],
                        highlightElevation: 6.0,
                        elevation: 4.0,
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Logout(),
                            ),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * .05;
    return Scaffold(
      appBar: appBarAll(context, "Sign up", "", true),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "assets/images/poll1.png",
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              bottom: 0.0,
              child: Container(
                padding:
                    EdgeInsets.only(top: topPadding, left: 55.0, right: 55.0),
                decoration:
                    BoxDecoration(color: Colors.yellow[400].withOpacity(0.95)),
                child: Form(
                  child: ListView(children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Confirm password",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        child: new Text(
                          'Sign up',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        splashColor: Colors.yellow[600],
                        color: Colors.yellow[500],
                        highlightElevation: 6.0,
                        elevation: 4.0,
                        onPressed: () {},
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewProfile extends StatefulWidget {
  final int userId;
  ViewProfile({this.userId});
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  Future<AccountModel> _account;

  @override
  void initState() {
    super.initState();
    this._account = viewProfile(widget.userId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * .05;
    return Scaffold(
      appBar: appBarSettings(context, "View profile"),
      body: FutureBuilder<AccountModel>(
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
                  child: Text('Sorry, we\'re having issues with our servers'),
                );
              } else if (snapshot.hasData) {
                return Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/poll1.png",
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        top: 0.0,
                        bottom: 0.0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: topPadding, left: 55.0, right: 55.0),
                          decoration: BoxDecoration(
                              color: Colors.yellow[400].withOpacity(0.95)),
                          child: Form(
                            child: ListView(children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(bottom: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          snapshot.data.profileImage,
                                        ),
                                        radius: 45.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                enabled: false,
                                initialValue: snapshot.data.name,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              TextFormField(
                                enabled: false,
                                initialValue: snapshot.data.username,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              TextFormField(
                                enabled: false,
                                initialValue: snapshot.data.profileInfo,
                                maxLines: 5,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
