import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/Screens/expanded_event.dart';
import 'package:learning/provider/from_snapshot.dart';

import 'event.dart';

List<String> returnEvents() {
  List<String> searchEvents = [];
  Firestore.instance.collection('events').snapshots().listen(
      (data) => data.documents.forEach((doc) => searchEvents.add(doc["name"])));
  return searchEvents;
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> _recentSearches;
  final List<String> _events;

  CustomSearchDelegate(List<String> events)
      : _events = returnEvents(),
        _recentSearches = <String>[],
        super();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    Firestore.instance.collection('events').document(query).get().then((
      DocumentSnapshot ds,
    ) {
      Event e = fromSnapshot(ds);


      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ExpandedEvent(
                    true,
                    event: e,
                  )));
    });
    return Scaffold(body: Center(child: CircularProgressIndicator()),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestionList = query.isEmpty
        ? _recentSearches
        : _events.where((p) => p.toLowerCase().contains(query));

    return _WordSuggestionList(
      query: this.query,
      suggestions: suggestionList.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._recentSearches.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: theme.primaryColorBrightness,
      primaryTextTheme: theme.primaryTextTheme,
    );
  }



}

class _WordSuggestionList extends StatelessWidget {
  const _WordSuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          // Highlight the substring that matched the query.
          title: Text(suggestion),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
