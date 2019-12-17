


import 'package:cloud_firestore/cloud_firestore.dart';

import 'event.dart';

Event fromSnapshot(
    DocumentSnapshot snapshot,
    ) {
  Event e = new Event(
      snapshot['name'],
      snapshot['hasPrice'],
      snapshot['price'],
      snapshot['city'],
      snapshot['hasAgeRestriction'],
      snapshot['ageRestriction'],
      snapshot['likes'],
      snapshot['isStarred'],
      snapshot['isInviteOnly'],
      snapshot['hasAlcohol'],
      snapshot['byob'],
      snapshot['genre'],
      snapshot['venue'],
      snapshot['dj'].split(','),
      snapshot['faq'],
      snapshot['description'],
      snapshot['imageURL'],
      snapshot['verified']);

  return e;
}