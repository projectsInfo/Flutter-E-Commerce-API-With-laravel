import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/widget/bottom-navigation-bar.dart';
import 'package:flutter_ecommerce/widget/drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapApi extends StatefulWidget {

  MapApi({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<MapApi> createState() => MapApiState();
}

class MapApiState extends State<MapApi> {

  DatabaseHelper databaseHelper = new DatabaseHelper();
  Map<MarkerId, Marker> markers = {};
  Location location = new Location();

  int _selectedIndex = 4;


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          getOurLocation();
        },
      ),
      drawer: Drawer(
        child: DrawerNavigationState(),
      ),
      bottomNavigationBar: NavigationBottom(number: _selectedIndex , ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  getOurLocation() async{
//    var pos = await location.getLocation();
    final MarkerId markerId = MarkerId('Our Location');

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.08832357078792),
      infoWindow: InfoWindow(title: 'Our Location', snippet: '*'),
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }
}

