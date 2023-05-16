import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/core/location/location_service.dart';
import 'package:medical_valley/features/home/history/data/negotiations/get_negotiations_api.dart';
import 'package:medical_valley/features/home/history/data/negotiations/negotiations_model.dart';

abstract class GetNegotiationsUseCase {
  Future<Either<Failure, NegotiationsResponse>> getNegotiations(
      int page, int pageSize);
}

class GetNegotiationsUseCaseImpl extends GetNegotiationsUseCase {
  NegotiationsClient negotiationsClient;

  GetNegotiationsUseCaseImpl(this.negotiationsClient);

  @override
  Future<Either<Failure, NegotiationsResponse>> getNegotiations(
      int page, int pageSize) async {
    var date = await negotiationsClient.getNegotiations(page, pageSize);
    var negotiationsResponse = NegotiationsResponse.fromJson(date);
    if (negotiationsResponse.responseCode == 200) {
      return getDistances(negotiationsResponse);
    } else {
      return Left(ServerFailure());
    }
  }

  double _getDistanceBetweenMeAndProvider(double latitude, double longitude) {
    return LocationServiceProvider.getDistanceBetweenCurrentAndLocation(
        latitude: latitude, longitude: longitude);
  }

  Either<Failure, NegotiationsResponse> getDistances(response) {
    response.data?.results?.forEach((NegotiationModel element) {
      double distance = _getDistanceBetweenMeAndProvider(
          element.providerLatitude!, element.providerLongitude!);
      element.distanceInMeter = distance.toStringAsFixed(2);
    });
    return Right(response);
  }
}
