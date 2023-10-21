import 'package:bloc/bloc.dart';
import 'package:medical_valley/features/payment/data/model/InvoiceInfo.dart';
import 'package:medical_valley/features/payment/domain/get_invoice_info_usecase.dart';
import 'package:meta/meta.dart';

part 'invoice_info_state.dart';

class InvoiceInfoCubit extends Cubit<InvoiceInfoState> {
  final GetInvoiceInfoUseCase getInvoiceInfoUseCase;
  InvoiceInfoCubit(this.getInvoiceInfoUseCase) : super(InvoiceInfoInitial());

  void getInvoiceInfo(int requestId) async {
    emit(InvoiceInfoLoading());
    final response = await getInvoiceInfoUseCase.execute(requestId);
    response.fold(
        (l) => emit(InvoiceInfoFailure()), (r) => emit(InvoiceInfoLoaded(r)));
  }
}
