import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/payment/data/model/get_invoice_response.dart';
import 'package:medical_valley/features/payment/data/model/make_invoice_response.dart';
import 'package:medical_valley/features/payment/domain/get_invoice_usecase.dart';
import 'package:medical_valley/features/payment/domain/make_invoice_usecase.dart';

class InvoiceBloc extends Cubit<InvoiceState> {
  InvoiceBloc(this.makeInvoiceUseCase, this.getInvoiceInfoUseCase)
      : super(IdleCreationInvoiceState());
  MakeInvoiceUseCase makeInvoiceUseCase;
  GetInvoiceUseCase getInvoiceInfoUseCase;
  createInvoice(int offerId) async {
    emit(LoadingCreationInvoiceState());

    var either = await makeInvoiceUseCase.createInvoice(offerId);
    either.fold((l) {
      emit(ErrorCreationInvoiceState());
    }, (r) {
      emit(SuccessCreationInvoiceState(r));
    });
  }

  getInvoice(String invoice) async {
    emit(LoadingInvoiceState());

    var either = await getInvoiceInfoUseCase.getInvoice(invoice);

    either.fold((l) {
      emit(ErrorInvoiceState());
    }, (r) {
      if (r.data?.paid ?? false) {
        emit(SuccessInvoiceState(r));
      } else {
        emit(ErrorInvoiceState());
      }
    });
  }
}

abstract class InvoiceState {}

class IdleCreationInvoiceState extends InvoiceState {}

class LoadingCreationInvoiceState extends InvoiceState {}

class SuccessCreationInvoiceState extends InvoiceState {
  MakeInvoiceResponse makeInvoiceResponse;

  SuccessCreationInvoiceState(this.makeInvoiceResponse);
}

class SuccessInvoiceState extends InvoiceState {
  GetInvoiceResponse getInvoiceInfoModel;

  SuccessInvoiceState(this.getInvoiceInfoModel);
}

class ErrorInvoiceState extends InvoiceState {
  ErrorInvoiceState();
}

class LoadingInvoiceState extends InvoiceState {
  LoadingInvoiceState();
}

class ErrorCreationInvoiceState extends InvoiceState {}
