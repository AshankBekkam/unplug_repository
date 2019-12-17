import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import '../provider/user_details.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Screens/login_screen.dart';
import '../Screens/home_screen.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatelessWidget {
  final GoogleSignIn _gSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Enter emergency contact number"),
            content: new TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (number) {
                Hive.box('emergency').add(number);
                Navigator.pop(context);


              },
            ),
            actions: <Widget>[FlatButton(),
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Hive.openBox('favourites');
    Hive.openBox('qr');
    Hive.openBox('emergency');

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          FlareActor(
            "images/background.flr",
            animation: '0',
            fit: BoxFit.fill,
          ),
          Positioned(
            width: width,
            top: height / 7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Hey!",
                  style: TextStyle(fontSize: 35, fontFamily: 'Raleway'),
                ),
                Hero(
                  tag: 'profile',
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        image: DecorationImage(
                            image: NetworkImage(details.photoUrl),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                  ),
                ),
                Text(details.userName,
                    style: TextStyle(fontSize: 35, fontFamily: 'Raleway')),
                //Spacer(),
                Container(
                  height: height / 5,
                  width: width * .9,
                  child: Card(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Stats",
                        style: TextStyle(
                          fontFamily: 'BebasNeue',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    color: Colors.lightBlueAccent,
                    elevation: 10,
                  ),
                ),
                RaisedButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text("Add Emergency Contact"),
                  onPressed: () {
                    _showDialog();
                  },
                ),

                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text("View Purchase History"),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white70),
                  ),
                  onPressed: () {
                    _gSignIn.signOut();
                    UserDetails.signedIn = false;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoogleSignApp()));
                  },
                ),
                SizedBox(height: 30),
                Container(
                  height: height / 10,
                  width: width * .9,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Text(
                      "Find Parties",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'BebasNeue',
                          letterSpacing: 1),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
