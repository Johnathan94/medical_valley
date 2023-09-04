import 'package:dartz/dartz.dart';
import 'package:medical_valley/features/payment/data/get_invoice_service/make_invoice_service.dart';
import 'package:medical_valley/features/payment/data/model/get_invoice_response.dart';

import '../../../core/failures/failures.dart';

class GetInvoiceUseCase {
  GetInvoiceClient client;

  GetInvoiceUseCase(this.client);

  Future<Either<Failure, GetInvoiceResponse>> getInvoice(
      String invoiceId) async {
    try {
      var response = await client.getInvoice(invoiceId);
      GetInvoiceResponse invoiceResponse =
          GetInvoiceResponse.fromJson(response);
      return Right(invoiceResponse);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
