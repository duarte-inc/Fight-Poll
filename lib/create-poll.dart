import 'package:flutter/material.dart';
import 'package:mma_poll/functions.dart';

class CreatePoll extends StatefulWidget {
  @override
  _CreatePollState createState() => _CreatePollState();
}

class _CreatePollState extends State<CreatePoll> {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * .125;
    return Scaffold(
      appBar: appBarAll(context, "Create Poll", "", true),
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
                        hintText: "Title:",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Fighter #1:",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Fighter #2:",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      onSaved: (String value) {
                        //Do Something
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 42.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Add Image",
                                style: TextStyle(),
                              ),
                            ),
                            Icon(
                              Icons.add_a_photo,
                              size: 40.0,
                            ),
                          ],
                          mainAxisSize: MainAxisSize.min,
                        ),
                      ),
                      onTap: () {
                        print("launch image picker");
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        child: new Text(
                          'Create Vote',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        splashColor: Colors.yellow[600],
                        color: Colors.yellow[500],
                        highlightElevation: 6.0,
                        elevation: 4.0,
                        onPressed: () {
                          print("poll created");
                        },
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
