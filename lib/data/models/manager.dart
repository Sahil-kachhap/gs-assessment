import 'dart:developer';

import 'package:rider_app/data/models/rider.dart';

class Manager{
  final String? name;
  static List<Rider> riders = [];

  Manager({this.name});

  List<Rider> getRiders() => riders;

  void addRider(Rider rider){
    riders.add(rider);
  }

  void approveRiderByManager(Rider rider){
    int riderIndex = riders.indexWhere((element) => element.phoneNumber == rider.phoneNumber);
    log(riders[riderIndex].isApproved.toString());
    log(riders[riderIndex].name!);
    riders[riderIndex].isApproved = true;
  }
}