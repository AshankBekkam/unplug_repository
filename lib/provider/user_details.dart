import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';



@HiveType()
class UserDetails {
  @HiveField(0)
  final String providerDetails;
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final String photoUrl;
  @HiveField(3)
  final String userEmail;
  @HiveField(4)
  final List<ProviderDetails> providerData;
  @HiveField(5)
  static bool signedIn = false;
  @HiveField(6)
  String emergencyContact;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

UserDetails details;

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}
