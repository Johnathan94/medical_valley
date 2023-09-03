import 'package:dartz/dartz.dart';
import 'package:medical_valley/features/payment/data/make_invoice_response.dart';
import 'package:medical_valley/features/payment/data/make_invoice_service/make_invoice_service.dart';

import '../../../core/failures/failures.dart';

class MakeInvoiceUseCase {
  MakeInvoiceClient client;

  MakeInvoiceUseCase(this.client);

  Future<Either<Failure, MakeInvoiceResponse>> createInvoice(
      int offerId) async {
    try {
      var response = await client.makeInvoice(offerId);
      MakeInvoiceResponse invoiceResponse =
          MakeInvoiceResponse.fromJson(response);
      return Right(invoiceResponse);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
