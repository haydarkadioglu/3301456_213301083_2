import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konum'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final locationData = await getLocationData();
                if (locationData != null) {
                  final placemarks = await placemarkFromCoordinates(
                    locationData.latitude!,
                    locationData.longitude!,
                  );
                  if (placemarks.isNotEmpty) {
                    final cityName = await placemarks.first.locality;
                    setState(() {
                      currentLocation = cityName;
                    });
                  }
                }
              },
              child: Text('Konumu Al'),
            ),
            SizedBox(height: 20),
            Text(
              'Mevcut Konum:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              currentLocation ?? 'Konum bilgisi bulunamadı.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<loc.LocationData?> getLocationData() async {
    try {
      final location = loc.Location();
      bool _serviceEnabled;
      loc.PermissionStatus _permissionGranted;
      loc.LocationData? _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == loc.PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != loc.PermissionStatus.granted) {
          return null;
        }
      }

      if (_permissionGranted == loc.PermissionStatus.granted) {
        _locationData = await location.getLocation();
        final latitude = _locationData.latitude;
        final longitude = _locationData.longitude;
        final coordinates = "$latitude, $longitude";
        final placemarks = await placemarkFromCoordinates(latitude!, longitude!);
        if (placemarks.isNotEmpty) {
          String? cityName = placemarks.first.locality ?? placemarks.first.subAdministrativeArea;
          print('Konum Verisi: $coordinates - ${cityName ?? 'Bilinmeyen Şehir'}');
          return _locationData;
        }
      }


      return null;
    } catch (error) {
      print("errrrrr: $error");
      return null;
    }
  }
}
