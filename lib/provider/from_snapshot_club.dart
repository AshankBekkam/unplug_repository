import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/provider/club_details.dart';

import 'club_details.dart';

Club fromSnapshotToClub(
  DocumentSnapshot snapshot,
) {
  Club c = new Club(
    snapshot['name'],
    snapshot['description'],
    snapshot['faq'],
    snapshot['hasGuestList'],
    snapshot['imageURL'],
    snapshot['isStarred'],
    snapshot['hasEntryFee'],
    snapshot['entryFee'],
    snapshot['city'],
    snapshot['verified'],
  );

  return c;
}
