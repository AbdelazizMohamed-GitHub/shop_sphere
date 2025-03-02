import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<Placemark> getLocation() async {
    try {
      // Check permission and request if necessary
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
      return Future.error( "Location permissions are permanently denied.");
   
        
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
       
      );

      // Convert coordinates to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        
   return place;
      } else {
        return Future.error("No address found");
       
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
