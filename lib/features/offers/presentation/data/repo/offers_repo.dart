import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/core/location/location_service.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/offers/presentation/data/api_service/offers_client.dart';
import 'package:medical_valley/features/offers/presentation/data/model/offers_response.dart';

abstract class OffersRepo {
  Future<Either<Failure , OffersResponse>> getOffers (int page , int pageSize , int serviceId , int categoryId);
}
 class OffersRepoImpl extends OffersRepo{
  OffersClient client ;

  OffersRepoImpl(this.client);

  @override
  Future<Either<Failure , OffersResponse>> getOffers(int page , int pageSize , int serviceId , int categoryId) async {
    try
     {
       String user = LocalStorageManager.getUser();
       Map<String , dynamic > currentUser = {} ;
       currentUser =  jsonDecode(user);
       var result = await client.getOffers(page, pageSize, serviceId, categoryId,currentUser["result"]["data"]["id"]);
       OffersResponse response = OffersResponse.fromJson(result);

       if(response.responseCode==200){
        return  getDistances(response);
       }
       return Left(ServerFailure());
     }
      catch(e){
      return Left(ServerFailure());
     }
  }
  double _getDistanceBetweenMeAndProvider(double latitude, double longitude) {
    return  LocationServiceProvider.getDistanceBetweenCurrentAndLocation(latitude: latitude , longitude: longitude);
  }

  Either<Failure , OffersResponse> getDistances(response) {
    response.data?.results?.forEach((OfferModel element) {
      double distance = _getDistanceBetweenMeAndProvider(element.latitude!, element.longitude!);
      element.distanceInMeter = distance.toStringAsFixed(2);
    });
    return Right(response);
  }

 }