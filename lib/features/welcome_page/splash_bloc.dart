import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_valley/core/location/location_service.dart';

class SplashBloc extends Cubit<SplashState> {
  SplashBloc() : super(IdleSplashState());
  getLocation() async {
    emit(IdleSplashState());
    Position? determinePosition =
        await LocationServiceProvider.determinePosition();
    if (determinePosition == null) {
      emit(ErrorSplashState());
    } else {
      emit(SuccessSplashState());
    }
  }
}

abstract class SplashState {}

class SuccessSplashState extends SplashState {}

class IdleSplashState extends SplashState {}

class ErrorSplashState extends SplashState {}
