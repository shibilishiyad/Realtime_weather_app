import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/placemarklocation.dart';

class Locationprovider with ChangeNotifier{

  Position?  _currentposition;

  Position? get currentposition=>  _currentposition;
  final LocationService _locationService =LocationService();
  Placemark ?_currentlocationname;
  Placemark? get currentlocationname=>_currentlocationname;

  Future<void>determainposition() async{

    bool serviceenabled;
    LocationPermission permission;
    serviceenabled=await Geolocator.isLocationServiceEnabled();

    //cheking location enabled or not 
    if(!serviceenabled){
      _currentposition =null;
      notifyListeners();
      return;
    }
    //cheking  have the location permition 
    permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){

      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){

        _currentposition=null;
        notifyListeners();
        return;
      }
    }

    if(permission==LocationPermission.deniedForever){

      _currentposition=null;
      notifyListeners();
      return;
    }

    //getting the latitude and logitude data to curent position variable 

    _currentposition=await Geolocator.getCurrentPosition();
    // print(_currentposition);
    _currentlocationname=await _locationService.getLocationName(_currentposition);
    // print(_currentlocationname);
    ChangeNotifier();
    


  }
}