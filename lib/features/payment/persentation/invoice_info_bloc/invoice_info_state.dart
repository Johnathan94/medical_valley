part of 'invoice_info_cubit.dart';

@immutable
abstract class InvoiceInfoState {}

class InvoiceInfoInitial extends InvoiceInfoState {}

class InvoiceInfoLoading extends InvoiceInfoState {}

class InvoiceInfoLoaded extends InvoiceInfoState {
  final InvoiceInfo invoiceInfo;
  InvoiceInfoLoaded(this.invoiceInfo);
}

class InvoiceInfoFailure extends InvoiceInfoState {}
