import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:medical_valley/features/home/widgets/home_base_stateful_widget.dart';
import 'package:rxdart/rxdart.dart';

class MapScreen extends StatefulWidget {
  final LatLng currentPosition;
  final bool hasAppBar;
  const MapScreen(this.currentPosition, {this.hasAppBar = false, super.key});

  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static late CameraPosition _kGooglePlex;
  late final Set<Marker> _markers = {};
  final BehaviorSubject<Set<Marker>> _markersSubject = BehaviorSubject();
  final BehaviorSubject<bool> confirmAddress = BehaviorSubject();
  @override
  initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(
          widget.currentPosition.latitude, widget.currentPosition.longitude),
      zoom: 20,
    );
    _markers.add(Marker(
        markerId: MarkerId(widget.currentPosition.hashCode.toString()),
        position: widget.currentPosition));
    _markersSubject.sink.add(_markers);
    confirmAddress.add(true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.hasAppBar
          ? AppBar()
          : const PreferredSize(preferredSize: Size.zero, child: SizedBox()),
      body: Stack(
        children: [
          StreamBuilder<Set<Marker>>(
              stream: _markersSubject.stream,
              builder: (context, snapshot) {
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  markers: _markersSubject.value,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onLongPress: (asd) {
                    _markers.clear();
                    _markers.add(Marker(
                        markerId: MarkerId(asd.hashCode.toString()),
                        position: asd,
                        icon: BitmapDescriptor.defaultMarker));
                    _markersSubject.sink.add(_markers);
                    confirmAddress.add(true);
                  },
                  onTap: (asd) {
                    _markers.clear();
                    _markers.add(Marker(
                        markerId: MarkerId(asd.hashCode.toString()),
                        position: asd,
                        icon: BitmapDescriptor.defaultMarker));
                    _markersSubject.sink.add(_markers);
                    confirmAddress.add(true);
                  },
                );
              }),
          StreamBuilder<bool>(
              stream: confirmAddress.stream,
              builder: (context, snapshot) {
                return Visibility(
                  visible:
                      confirmAddress.hasValue ? confirmAddress.value : false,
                  child: Positioned(
                      bottom: 90,
                      right: 50,
                      left: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          /*  bool isIn = await isInRidyhZone(_markersSubject.value.first.position);
                          if (isIn) {
                        */
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomeBaseStatefulWidget()));
                          /* } else {
                            context.showSnackBar(AppLocalizations.of(context)!
                                .this_app_available_in_Ridyh);
                          }*/
                        },
                        child: Text(
                            AppLocalizations.of(context)!.confirm_addresss),
                      )),
                );
              })
        ],
      ),
      /*   floatingActionButton: FloatingActionButton(
        onPressed: () {
          _searchPlaces();
        },
      ),*/
    );
  }

  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "AIzaSyAtT-rES3IYix7NJM0SpxbM3CPThEjwbc4");
  GoogleMapController? _mapController;

  Future<bool> isInRidyhZone(LatLng position) async {
    double ridyhZoneLat = 12.3456;
    double ridyhZoneLng = 78.9012;

    // Get the user's current position
    //Position position = await Geolocator.getCurrentPosition();

    // Compare the user's position with the "ridyh zone" boundaries
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      ridyhZoneLat,
      ridyhZoneLng,
    );

    // Set a threshold distance within which the user is considered to be in the zone
    double zoneRadius = 500; // in meters

    return distanceInMeters <= zoneRadius;
  }

  void _searchPlaces() async {
    final location = Location(
      lat: _markers.first.position.latitude,
      lng: _markers.first.position.longitude,
    );
    final response = await _places.searchNearbyWithRadius(location, 5000,
        type: 'restaurant');

    if (response.isOkay) {
      // Process the search results and display on the map
      for (PlacesSearchResult result in response.results) {
        final placeId = result.placeId;
        final location = result.geometry?.location;

        if (location != null) {
          final marker = Marker(
            markerId: MarkerId(placeId!),
            position: LatLng(location.lat, location.lng),
            infoWindow: InfoWindow(
              title: result.name,
              snippet: result.vicinity,
            ),
          );

          _markers.add(marker);
          _markersSubject.sink.add(_markers);
        }
      }
    } else {
      // Handle error when search fails
      print('Error searching places: ${response.errorMessage}');
    }
  }
}
