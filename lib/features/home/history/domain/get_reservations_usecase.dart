import 'package:medical_valley/core/location/location_service.dart';
import 'package:medical_valley/features/home/history/data/reservations/get_reservations_api.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';

abstract class GetReservationsUseCase {
  Future<ReservationsResponse> getReservations(int page, int pageSize);
}

class GetReservationsUseCaseImpl extends GetReservationsUseCase {
  ReservationsClient reservationClient;

  GetReservationsUseCaseImpl(this.reservationClient);

  @override
  Future<ReservationsResponse> getReservations(int page, int pageSize) async {
    var date = await reservationClient.getReservations(page, pageSize);
    var response = ReservationsResponse.fromJson(date);
    return getDistances(response);
  }

  double _getDistanceBetweenMeAndProvider(double latitude, double longitude) {
    return LocationServiceProvider.getDistanceBetweenCurrentAndLocation(
        latitude: latitude, longitude: longitude);
  }

  ReservationsResponse getDistances(response) {
    response.data?.results?.forEach((ReservationModel element) {
      double distance = _getDistanceBetweenMeAndProvider(
          element.providerLatitude!, element.providerLongitude!);
      element.distanceInMeter = distance.toStringAsFixed(2);
    });
    return response;
  }
}
