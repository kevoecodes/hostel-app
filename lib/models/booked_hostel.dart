import 'package:house_rent/models/house.dart';

class BookedHostel {
  static int PENDING = 0;
  static int ACCEPTED = 1;
  static int REJECTED = 2;
  String id;
  int status;
  House house;

  BookedHostel(this.id, this.status, this.house);

  getStatus() {
    if (status == PENDING) {
      return 'Pending';
    } else if (status == ACCEPTED) {
      return 'Accepted';
    } else if (status == REJECTED) {
      return 'Rejected';
    } else {
      return 'Unknown Status';
    }
  }
}
