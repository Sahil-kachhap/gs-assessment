import 'package:rider_app/data/models/manager.dart';
import 'package:rider_app/data/models/rider.dart';

class ScreenRiders {
  Manager manager = Manager();

  removeRider(Rider rider) {
    manager
        .getRiders()
        .removeWhere((riderX) => riderX.phoneNumber == rider.phoneNumber);
  }

  approveRider(Rider rider) {
    manager.approveRiderByManager(rider);
  }
}
