abstract class Failure {}

class ServerFailure extends Failure {
  String? error;

  ServerFailure({this.error});
}
