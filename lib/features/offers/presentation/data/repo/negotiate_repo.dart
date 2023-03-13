import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/offers/presentation/data/api_service/negotiate_client.dart';
import 'package:medical_valley/features/offers/presentation/data/model/negotiate_model.dart';
import 'package:medical_valley/features/offers/presentation/data/model/offers_response.dart';

abstract class NegotiateRepo {
  Future<Either<Failure , Unit>> negotiate (List<int?> offerIds);
}
 class NegotiateRepoImpl extends NegotiateRepo{
  NegotiateClient client ;

  NegotiateRepoImpl(this.client);

  @override
  Future<Either<Failure , Unit>> negotiate(List<int?> offerIds) async {
    try
     {
       String user = LocalStorageManager.getUser();
       Map<String , dynamic > currentUser = {} ;
       currentUser =  jsonDecode(user);
       var result = await client.negotiate(NegotiateModel(
         id: currentUser["result"]["data"]["id"],
         offerId: []
       ));
       OffersResponse response = OffersResponse.fromJson(result);

       if(response.responseCode==200){
        return  const Right(unit);
       }
       return Left(ServerFailure());
     }
      catch(e){
      return Left(ServerFailure());
     }
  }

 }