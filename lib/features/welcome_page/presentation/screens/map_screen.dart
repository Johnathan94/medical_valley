import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static late CameraPosition _kGooglePlex;
  late final Set<Marker> _markers = {};
  final BehaviorSubject<Set<Marker>> _markersSubject = BehaviorSubject();
  @override
  initState() {
    _kGooglePlex = const CameraPosition(
      target: LatLng(37.337203, -122.079862218),
      zoom: 14.4746,
    );
    _markersSubject.sink.add(_markers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Set<Marker>>(
          stream: _markersSubject.stream,
          builder: (context, snapshot) {
            return GoogleMap(
              mapType: MapType.hybrid,
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
              },
              onTap: (asd) {
                _markers.clear();
                _markers.add(Marker(
                    markerId: MarkerId(asd.hashCode.toString()),
                    position: asd,
                    icon: BitmapDescriptor.defaultMarker));
                _markersSubject.sink.add(_markers);
              },
            );
          }),
    );
  }
}
