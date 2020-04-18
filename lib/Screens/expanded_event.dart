import 'package:flutter/material.dart';
import 'package:learning/Screens/payment_page.dart';
import 'package:learning/Screens/story_screen.dart';
import 'package:learning/provider/club_details.dart';
import 'package:learning/provider/share_function.dart';
import '../provider/event.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:story_view/story_view.dart';
import 'package:hive/hive.dart';
import '../provider/favourites.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExpandedEvent extends StatefulWidget {
  final Event event;
  final Club club;
  final bool _isEvent;


  ExpandedEvent(this._isEvent, {this.club, this.event});

  @override
  _ExpandedEventState createState() => _ExpandedEventState();
}

class _ExpandedEventState extends State<ExpandedEvent> {
  Box favouritesBox;
  //Box isFavourite;
  List<String> storyList;
  int numberOfStories;

  List<StoryItem> tempStoryList = new List<StoryItem>(10);
  //bool favouriteSelected;

  Future _openBox() async {
    favouritesBox = await Hive.openBox('favourites');
    return;
  }

  /*Future _openFavBox() async{
    isFavourite = await Hive.openBox('isFavourite');
    return;
  }*/

  /*Future getStories(String userName) async {
    storyList = new List<String>(3);

    String link = 'https://api.storiesig.com/stories/$userName';
    tempStoryList = [
      StoryItem.pageVideo(
          'https://scontent-sjc3-1.cdninstagram.com/v/t50.12441-16/80549810_2640090626072077_9070999709648710594_n.mp4?_nc_ht=scontent-sjc3-1.cdninstagram.com&_nc_cat=101&oe=5DFCFE65&oh=20e7db9fb282a2f61cabe2363ebc090c'),
      StoryItem.pageVideo(
          'https://scontent-sjc3-1.cdninstagram.com/v/t50.12441-16/81352777_2399543333491447_8566035913777393946_n.mp4?_nc_ht=scontent-sjc3-1.cdninstagram.com&_nc_cat=107&_nc_ohc=gIxvNGrHyrQAX87F-lA&oe=5DFD9147&oh=e4dcc83c740fbed1bcf98a13c8a5fc0f')
    ];
    var res = await http
        .get(link);
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var story = data['items'] as List;
      print('---');
      print(story.length);
      numberOfStories = story.length;
      print(story[0]['video_versions'][0]['url']);
      for (int i = 0; i < story.length; i++) {
        //storyList.add(StoryItem.pageVideo(story[i]["video_versions"][0]['url']));
        print(story[i]["video_versions"][0]['url']);
        storyList[i] = story[i]["video_versions"][0]['url'];

      }
    }
    else throw 'Cant get stories';
    return;

  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openBox();
    //getStories('nasa');

    //_openFavBox();
  }

  @override
  Widget build(BuildContext context) {
    //getStories('nasa');
    _openBox();
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 75,
        width: 75,
        child: FloatingActionButton(
            child: Icon(Icons.attach_money),
            onPressed: () {
              Navigator.push(
                  context,
                  widget._isEvent
                      ? MaterialPageRoute(
                          builder: (context) => PaymentPage(
                                widget._isEvent,
                                bEvent: widget.event,
                              ))
                      : MaterialPageRoute(
                          builder: (context) => PaymentPage(
                                widget._isEvent,
                                bClub: widget.club,
                              )));
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 4,
        color: Colors.deepPurple,
        notchMargin: 8,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Container(width: 0,),
              widget._isEvent
                  ? IconButton(
                      icon: Icon(Icons.favorite),
                      iconSize: 50,
                      color: (Hive.box('favourites')
                              .containsKey(widget.event.name))
                          ? Colors.pink
                          : Colors.white,
                      onPressed: () {
                        if (Hive.box('favourites')
                                .containsKey(widget.event.name) ==
                            false) {
                          setState(() {
                            (Hive.box('favourites')
                                .put(widget.event.name, widget.event));
                          });
                        } else {
                          setState(() {
                            (Hive.box('favourites').delete(widget.event.name));
                          });
                        }
                      },
                    )
                  : Container(height: 0, width: 0),

              IconButton(
                icon: Icon(Icons.share),
                iconSize: 40,
                color: Colors.white,
                onPressed: () {
                  share(context, widget.event);
                },
              ), //Container(width: 0,)
            ],
          ),
          height: height * .07,
        ),
        shape: CircularNotchedRectangle(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: height * .3,
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                child: Container(
                  child: Image.network(
                    widget._isEvent
                        ? widget.event.imageURL
                        : widget.club.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
                tag:
                    '${widget._isEvent ? widget.event.name : widget.club.name}',
              ),
              title:
                  Text(widget._isEvent ? widget.event.name : widget.club.name),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  widget._isEvent
                      ? widget.event.name
                      : widget.club.name, //modified
                  style: TextStyle(fontSize: 20, fontFamily: 'Raleway-Bold'),
                ),
              ),
              Row(
                children: <Widget>[
                  /*GestureDetector(
                    onTap: () {



                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoryPageView(storyList)));

                      /*return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );*/
                    },
                    child: widget._isEvent
                        ? Container(
                            height: 0,
                            width: 0,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.deepPurpleAccent,
                            radius: 40,
                          ),
                  )*/
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Text(
                      widget._isEvent ? widget.event.venue : widget.club.city,
                      style:
                          TextStyle(fontSize: 30, fontFamily: 'Raleway-Bold'),
                    ),
                  ),
                ],
              ),
              Container(
                child: Text(
                  widget._isEvent
                      ? widget.event.price
                      : (widget.club.hasEntryFee ? widget.club.entryFee : ""),
                  style: TextStyle(fontSize: 30, fontFamily: 'Raleway-Bold'),
                ),
              ),
              Container(
                child: Text(
                  widget._isEvent
                      ? widget.event.description
                      : widget.club.description,
                  style: TextStyle(fontSize: 30, fontFamily: 'Raleway-Bold'),
                ),
              ),
              Container(height: 600, color: Colors.transparent),
            ]),
          )
        ],
      ),
    );
  }
}
