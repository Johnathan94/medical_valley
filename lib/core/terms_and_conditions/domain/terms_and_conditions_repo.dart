
import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';
import '../data/terms_and_conditions_client.dart';
import '../data/terms_and_conditions_model.dart';

abstract class TermsAndConditionsRepo {
  Future<Either<Failure, TermsAndConditionsModel>> getTermsAndCondition();
}

class TermsAndConditionsImpl extends TermsAndConditionsRepo {
  TermsAndConditionsClient termsAndConditionsClient;

  TermsAndConditionsImpl(this.termsAndConditionsClient);

  @override
  Future<Either<Failure, TermsAndConditionsModel>> getTermsAndCondition() async {
    try {
      var result = await termsAndConditionsClient.getTermsAndConditions();
      if(result["termsConditions"].toString().isNotEmpty){
        return Right(TermsAndConditionsModel.fromJson(result));
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}