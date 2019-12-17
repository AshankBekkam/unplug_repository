import 'package:flutter/material.dart';
import 'package:learning/Screens/profile_page.dart';
import 'package:learning/provider/club_details.dart';
import './provider/user_details.dart';
import './Screens/login_screen.dart';
import './Screens/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import './provider/event.dart';

void main() async {

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(EventAdapter(), 0);
  Hive.registerAdapter(ClubAdapter(), 1);
  //Hive.registerAdapter(UserDetailsAdapter(), 2);

  runApp(MyApp());

  final favouritesBox = await Hive.openBox('favourites');
  final invitesBox = await Hive.openBox('qr');
  final emergency = await Hive.openBox('emergency');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            accentColor: Colors.white,

            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
            primaryTextTheme: TextTheme(body1: TextStyle(color: Colors.white))),
        home:GoogleSignApp());//UserDetails.signedIn?ProfilePage():GoogleSignApp());
  }
}
