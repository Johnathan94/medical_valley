import 'package:dartz/dartz.dart';
import 'package:medical_valley/features/payment/data/make_invoice_service/make_invoice_service.dart';
import 'package:medical_valley/features/payment/data/model/InvoiceInfo.dart';
import '../../../core/failures/failures.dart';

class GetInvoiceInfoUseCase {
  final MakeInvoiceClient client;

  GetInvoiceInfoUseCase(this.client);

  Future<Either<Failure, InvoiceInfo>> execute(int requestId) async {
    try {
      var response = await client.getInvoiceInfo(requestId);
      InvoiceInfo invoiceInfo = InvoiceInfo.fromJson(response.data);
      return Right(invoiceInfo);
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}
