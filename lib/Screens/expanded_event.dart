import 'package:flutter/material.dart';
import 'package:learning/Screens/payment_page.dart';
import 'package:learning/provider/club_details.dart';
import 'package:learning/provider/share_function.dart';
import '../provider/event.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../provider/favourites.dart';

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
  //bool favouriteSelected;

  Future _openBox() async {
    favouritesBox = await Hive.openBox('favourites');
    return;
  }

  /*Future _openFavBox() async{
    isFavourite = await Hive.openBox('isFavourite');
    return;
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openBox();
    //_openFavBox();
  }

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: BottomAppBar(elevation: 4,
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
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      widget._isEvent
                          ? widget.event.name
                          : widget.club.name, //modified
                      style:
                          TextStyle(fontSize: 20, fontFamily: 'Raleway-Bold'),
                    ),
                  ),
                ],
              ),
              Container(
                child: Text(
                  widget._isEvent ? widget.event.venue : "",
                  style: TextStyle(fontSize: 30, fontFamily: 'Raleway-Bold'),
                ),
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
