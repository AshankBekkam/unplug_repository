import 'package:flutter/material.dart';
import 'package:learning/Screens/club_list.dart';
import 'package:learning/Screens/home_screen.dart';
import 'package:learning/Screens/invites_screen.dart';
import '../Screens/profile_page.dart';
import '../provider/user_details.dart';
import '../Screens/favourites_screen.dart';
import 'package:hive/hive.dart';
class SideDrawer extends StatelessWidget {



  const SideDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 6,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage('images/u.png'),
                      fit: BoxFit.scaleDown))),
          ListTile(
            title: Text(
              "Profile",
              style: TextStyle(fontFamily: 'BebasNeue', fontSize: 30),
            ),
            leading: Hero(tag: 'profile',
              child: Icon(
                Icons.account_circle,
                size: 30,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              "Invites",
              style: TextStyle(fontFamily: 'BebasNeue', fontSize: 30),
            ),
            leading: Icon(
              Icons.stars,
              size: 30,
            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>InviteGrid()));
            },
          ),
          ListTile(
            title: Text(
              "Clubs",
              style: TextStyle(fontFamily: 'BebasNeue', fontSize: 30),
            ),
            leading: Icon(
              Icons.star,
              size: 30,
            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>ClubScreen()));
            },
          ),
          ListTile(
            title: Text(
              "Favourites",
              style: TextStyle(fontFamily: 'BebasNeue', fontSize: 30),
            ),
            leading: Icon(
              Icons.favorite,
              size: 30,
            ),
            onTap: () {


              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyFavourites()));
            },
          ),
          ListTile(
            title: Text(
              "Parties",
              style: TextStyle(fontFamily: 'BebasNeue', fontSize: 30),
            ),
            leading: Icon(
              Icons.details,
              size: 30,
            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
          )
        ],
      ),
    );
  }
}
