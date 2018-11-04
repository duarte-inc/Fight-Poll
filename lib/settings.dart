import 'package:flutter/material.dart';
import 'package:mma_poll/functions.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSettings(context, "Settings"),
      body: Column(
        children: <Widget>[
          Container(
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text("Edit Profile"),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ),
          Container(
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text("Change Password"),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ),
          Container(
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsOfUse(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text("Terms of use"),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ),
          Container(
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicy(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text("Privacy Policy"),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: FlatButton(
                      textColor: Colors.blueAccent,
                      onPressed: () {
                        print("log out");
                      },
                      child: Text("Log out"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////------Edit Profile------////////////////////////////////////////
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          padding: EdgeInsets.only(left: 24.0),
          alignment: Alignment.center,
          child: Text("Edit profile"),
        ),
        actions: <Widget>[save],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: 30.0,
              left: 45.0,
              bottom: 30.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                      'https://twt-media.washtimes.com/media/image/2016/07/06/JonJones.jpg'),
                ),
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            child: Text("data"),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////------Change Password------////////////////////////////

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          padding: EdgeInsets.only(left: 24.0),
          alignment: Alignment.center,
          child: Text("Password"),
        ),
        actions: <Widget>[save],
      ),
      body: Container(
        child: Text("Change Password"),
      ),
    );
  }
}

///////////////////////////////////------Terms of Conditions------//////////////////////
class TermsOfUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSettings(context, "Terms of use"),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "Some legal stuff regarding its use. Feel free to add some cool stuff here.",
          style: TextStyle(height: 1.1),
        ),
      ),
    );
  }
}

///////////////////////////////////------Privacy Policy------////////////////////////////
class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSettings(context, "Privacy policy"),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "Some legal stuff regarding the apps privacy. Forexample, you can say, 'the informations we collect will be used/sold to third party business. Or not!' ",
          style: TextStyle(height: 1.1),
        ),
      ),
    );
  }
}

Widget save = FlatButton(
  padding: EdgeInsets.only(left: 15.0),
  textColor: Colors.blueAccent,
  onPressed: () {
    print("Save");
  },
  child: Text(
    "Save",
    style: TextStyle(fontSize: 16.0),
  ),
);
