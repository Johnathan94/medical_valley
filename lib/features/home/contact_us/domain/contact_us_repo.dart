import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/home/contact_us/data/api/contact_us_client.dart';
import 'package:medical_valley/features/home/contact_us/data/model/contact_us_response_model.dart';

abstract class ContactUsRepo {
  Future<Either<Failure , Unit>> contactUs (ContactUsModel mobile);
}
class ContactUsRepoImpl extends ContactUsRepo{
  ContactUsClient client ;

  ContactUsRepoImpl(this.client);

  @override
  Future<Either<Failure , Unit>> contactUs(ContactUsModel model) async {
    try
    {
      var result = await client.contactUs(model);
      ContactUsResponse contactUsResponse =ContactUsResponse.fromJson(result);
      if(contactUsResponse.responseCode == 201 || contactUsResponse.responseCode ==200 ){
        return const Right(unit);
      }
      return Left(ServerFailure());
    }
    catch(e){
      return Left(ServerFailure());
    }
  }
}