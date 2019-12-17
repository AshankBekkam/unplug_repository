import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import '../provider/user_details.dart';
import '../Screens/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleSignApp extends StatefulWidget {
  @override
  _GoogleSignAppState createState() => _GoogleSignAppState();
}

class _GoogleSignAppState extends State<GoogleSignApp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
    ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);

    FirebaseUser userDetails = authResult.user;
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails onLoginDetails = new UserDetails(
        userDetails.providerId,
        userDetails.displayName,
        userDetails.photoUrl,
        userDetails.email,
        providerData);
    UserDetails.signedIn = true;

    details = onLoginDetails;
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ProfilePage(),
      ),
    );
    Firestore.instance
        .collection('users')
        .document(userDetails.displayName)
        .setData({
      'displayName': userDetails.displayName,
      'email': userDetails.email,
      'phoneNumber': userDetails.phoneNumber,
      'photoUrl': userDetails.photoUrl
    });

    return userDetails;
  }

  @override
  Widget build(BuildContext context) { 

    Hive.openBox('emergency');

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Builder(
          builder: (context) => Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Unplug',
                      style: TextStyle(fontSize: 50, fontFamily: 'BebasNeue'),
                    ),
                    SizedBox(
                      height: height * .15,
                    ),
                    Container(
                      height: height / 12,
                      width: width * .9,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 33,
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              'Sign in with Google',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ],
                        ),
                        onPressed: () => _signIn(context)
                            .then((FirebaseUser user) => print(user))
                            .catchError((e) => print(e)),
                      ),


                    ),
                    SizedBox(
                      height: height * .15,
                    ),
                    RaisedButton(child: Text('Emergency'),onPressed: (){

                      String emergencyNumber = Hive.box('emergency').getAt(Hive.box('emergency').length-2);
                      _launchEmergency(emergencyNumber);



                    },)
                  ],
                ),
              )),
    );
  }

  _launchEmergency(emnum) async{
    var url = 'tel:+91$emnum';
    if(await canLaunch(url)){
      await launch(url);

    }
    else{
      throw 'Could not launch $url';
    }

  }

}
