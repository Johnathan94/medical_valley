import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_valley/features/home/widgets/home_base_stateful_widget.dart';
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
  final BehaviorSubject<bool> confirmAddress = BehaviorSubject();
  @override
  initState() {
    _kGooglePlex = const CameraPosition(
      target: LatLng(24.7251918, 46.8225288),
      zoom: 14.4746,
    );
    _markersSubject.sink.add(_markers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          StreamBuilder<Set<Marker>>(
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomeBaseStatefulWidget()));
                        },
                        child: Text(
                            AppLocalizations.of(context)!.confirm_addresss),
                      )),
                );
              })
        ],
      ),
    );
  }
}
