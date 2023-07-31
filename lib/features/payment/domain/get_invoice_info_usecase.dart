import 'package:dartz/dartz.dart';
import 'package:medical_valley/features/payment/data/get_invoice_info_service/get_invoice_info_service.dart';

import '../../../core/failures/failures.dart';

class GetInvoiceInfoUseCase {
  GetInvoiceInfoService client;

  GetInvoiceInfoUseCase(this.client);

  Future<Either<Failure, GetInvoiceInfoModel>> createInvoice(
      String uuid) async {
    try {
      await client.getInvoiceService(uuid);
      return Right(GetInvoiceInfoModel());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

class GetInvoiceInfoModel {}
