import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // this class is converting the data (latitutde and logitude value got in _cureeent postion variable ) to place mark

  Future<Placemark?> getLocationName(Position? position) async {
    if (position != null) {
      try {
        final placemark = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        if (placemark.isNotEmpty) {
          return placemark[0];
        }
      } catch (e) {
        print('error fetching location ');
      }
      
    }
    return null;
  }
}
