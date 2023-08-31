import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/offers/presentation/data/api_service/negotiate_client.dart';
import 'package:medical_valley/features/offers/presentation/data/model/book_response.dart';
import 'package:medical_valley/features/offers/presentation/data/model/negotiate_model.dart';
import 'package:medical_valley/features/offers/presentation/data/model/negotiate_reponse.dart';

abstract class NegotiateRepo {
  Future<Either<ServerFailure, Unit>> negotiate(List<int>? offerIds);
  Future<Either<Failure, Unit>> verifyBook(int id);
}

class NegotiateRepoImpl extends NegotiateRepo {
  NegotiateClient client;

  NegotiateRepoImpl(this.client);

  @override
  Future<Either<ServerFailure, Unit>> negotiate(List<int>? offerIds) async {
    try {
      UserDate currentUser = UserDate.fromJson(LocalStorageManager.getUser()!);

      var result = await client
          .negotiate(NegotiateModel(userId: currentUser.id, offers: offerIds));
      NegotiateResponse response = NegotiateResponse.fromJson(result);

      if (response.responseCode! >= 200 && response.responseCode! < 300) {
        return const Right(unit);
      }
      return Left(ServerFailure(error: response.message));
    } on DioError catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyBook(int id) async {
    try {
      var result = await client.verifyRequest(id);
      BookResponse response = BookResponse.fromJson(result);

      if (response.responseCode! >= 200 && response.responseCode! < 300) {
        return const Right(unit);
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
