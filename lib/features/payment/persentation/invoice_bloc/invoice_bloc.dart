import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/payment/domain/make_invoice_usecase.dart';

class InvoiceBloc extends Cubit<InvoiceState> {
  InvoiceBloc(this.makeInvoiceUseCase) : super(IdleCreationInvoiceState());
  MakeInvoiceUseCase makeInvoiceUseCase;
  createInvoice(int offerId) async {
    emit(LoadingCreationInvoiceState());

    var either = await makeInvoiceUseCase.createInvoice(offerId);
    either.fold((l) {
      emit(ErrorCreationInvoiceState());
    }, (r) {
      emit(SuccessCreationInvoiceState());
    });
  }
}

abstract class InvoiceState {}

class IdleCreationInvoiceState extends InvoiceState {}

class LoadingCreationInvoiceState extends InvoiceState {}

class SuccessCreationInvoiceState extends InvoiceState {}

class ErrorCreationInvoiceState extends InvoiceState {}
