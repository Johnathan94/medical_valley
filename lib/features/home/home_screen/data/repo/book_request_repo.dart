import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_client.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_model.dart';
import 'package:medical_valley/features/home/home_screen/data/requests_model.dart';

class BookRequestRepo {
  BookRequestClient bookRequestClient;

  BookRequestRepo(this.bookRequestClient);

  Future<Either<ServerFailure, Unit>> sendRequest(
      BookRequestModel model) async {
    var response = await bookRequestClient.sendRequest(model);
    if (response["responseCode"] == 200 || response["responseCode"] == 201) {
      return const Right(unit);
    } else {
      return Left(ServerFailure(error: response["message"]));
    }
  }

  Future<Either<ServerFailure, int>> getRequests() async {
    var response = await bookRequestClient.getRequests();
    var requestsResponse = RequestsResponse.fromJson(response);
    if (requestsResponse.responseCode == 200) {
      return Right(requestsResponse.data!.results!.first.id!);
    } else {
      return Left(ServerFailure(error: response["message"]));
    }
  }
}
