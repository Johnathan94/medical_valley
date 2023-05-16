import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/offers/presentation/data/api_service/negotiate_client.dart';
import 'package:medical_valley/features/offers/presentation/data/model/negotiate_model.dart';
import 'package:medical_valley/features/offers/presentation/data/model/negotiate_reponse.dart';
import 'package:medical_valley/features/offers/presentation/data/model/verifyModel/verify_model.dart';

abstract class NegotiateRepo {
  Future<Either<Failure, Unit>> negotiate(List<int>? offerIds);
  Future<Either<Failure, Unit>> verifyBook(VerifyRequest verifyRequest);
}

class NegotiateRepoImpl extends NegotiateRepo {
  NegotiateClient client;

  NegotiateRepoImpl(this.client);

  @override
  Future<Either<Failure, Unit>> negotiate(List<int>? offerIds) async {
    try {
      UserDate currentUser = UserDate.fromJson(LocalStorageManager.getUser()!);

      var result = await client
          .negotiate(NegotiateModel(userId: currentUser.id, offers: offerIds));
      NegotiateResponse response = NegotiateResponse.fromJson(result);

      if (response.responseCode! >= 200 && response.responseCode! < 300) {
        return const Right(unit);
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyBook(VerifyRequest verifyRequest) async {
    try {
      var result = await client.verifyRequest(verifyRequest);
      NegotiateResponse response = NegotiateResponse.fromJson(result);

      if (response.responseCode! >= 200 && response.responseCode! < 300) {
        return const Right(unit);
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
