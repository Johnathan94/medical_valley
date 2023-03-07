import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/offers/presentation/data/api_service/offers_client.dart';

abstract class OffersRepo {
  Future<Either<Failure , Unit>> getOffers (int page , int pageSize , int serviceId , int categoryId);
}
 class OffersRepoImpl extends OffersRepo{
  OffersClient client ;

  OffersRepoImpl(this.client);

  @override
  Future<Either<Failure , Unit>> getOffers(int page , int pageSize , int serviceId , int categoryId) async {
    try
     {
       var result = await client.getOffers(page, pageSize, serviceId, categoryId);
       if(result["result"]["responseCode"]==200){
         return const Right(unit);
       }
       return Left(ServerFailure());
     }
      catch(e){
      return Left(ServerFailure());
     }
  }
}