import 'package:dartz/dartz.dart';
import 'package:medical_valley/features/payment/data/make_invoice_service/make_invoice_service.dart';

import '../../../core/failures/failures.dart';

class MakeInvoiceUseCase {
  MakeInvoiceClient client;

  MakeInvoiceUseCase(this.client);

  Future<Either<Failure, CreateInvoiceInfoModel>> createInvoice(
      int offerId) async {
    try {
      await client.makeInvoice(offerId);
      return Right(CreateInvoiceInfoModel());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

class CreateInvoiceInfoModel {}
