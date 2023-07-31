import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/features/home/widgets/home_base_stateful_widget.dart';
import 'package:medical_valley/features/welcome_page/data/update_location_request.dart';
import 'package:medical_valley/features/welcome_page/data/update_user_location_client.dart';
import 'package:medical_valley/main.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/base_service/dio_manager.dart';

class MapScreen extends StatefulWidget {
  final bool hasAppBar;
  const MapScreen({this.hasAppBar = false, super.key});

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
    LatLng temp = const LatLng(31.1231231, 31.12312312313);
    _kGooglePlex = CameraPosition(
      target: temp,
      zoom: 20,
    );
    _markers.add(
        Marker(markerId: MarkerId(temp.hashCode.toString()), position: temp));
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
          StreamBuilder<Position>(
              stream: currentLocationSubject.stream,
              builder: (context, mySnapshot) {
                if (mySnapshot.data != null) {
                  _kGooglePlex = CameraPosition(
                    target: LatLng(
                        mySnapshot.data!.latitude, mySnapshot.data!.longitude),
                    zoom: 18,
                  );
                  _markers.add(Marker(
                      markerId: MarkerId(mySnapshot.data!.hashCode.toString()),
                      position: LatLng(
                        mySnapshot.data!.latitude,
                        mySnapshot.data!.longitude,
                      )));
                  _markersSubject.sink.add(_markers);
                  confirmAddress.add(true);
                }
                return StreamBuilder<Set<Marker>>(
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
                    });
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
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  _markers.first.position.latitude,
                                  _markers.first.position.longitude);
                          LoadingDialogs.showLoadingDialog(context);
                          await UpdateUserLocationClient(DioManager.getDio())
                              .updateLocation(UpdateLocationRequest(
                                  longitude: _markers.first.position.longitude,
                                  latitude: _markers.first.position.latitude,
                                  location:
                                      "${placemarks[0].name} ${placemarks[0].street} ${placemarks[0].administrativeArea},${placemarks[0].country} "));
                          LoadingDialogs.hideLoadingDialog();
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
    );
  }

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
}
