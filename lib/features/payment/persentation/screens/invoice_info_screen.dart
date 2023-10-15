import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/features/payment/persentation/invoice_info_bloc/invoice_info_cubit.dart';
import 'package:medical_valley/core/extensions/string_extensions.dart';
import 'package:medical_valley/features/payment/persentation/screens/loading_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvoiceInfoScreen extends StatefulWidget {
  final int requestId;

  const InvoiceInfoScreen({Key? key, required this.requestId})
      : super(key: key);

  @override
  State<InvoiceInfoScreen> createState() => _InvoiceInfoScreenState();
}

class _InvoiceInfoScreenState extends State<InvoiceInfoScreen> {
  @override
  void initState() {
    context.read<InvoiceInfoCubit>().getInvoiceInfo(widget.requestId);
    super.initState();
  }

  final padding = const EdgeInsets.all(10);
  final double fontSize = 13.0;
  final verticalSpacing = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.invoice),
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.close,
            color: whiteColor,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: BlocBuilder<InvoiceInfoCubit, InvoiceInfoState>(
        builder: (context, state) {
          if (state is InvoiceInfoLoaded) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        padding: padding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildLightRow(
                              'Invoice number',
                              state.invoiceInfo.data?.invoiceID ?? "-",
                              'رقم الفاتورة',
                            ),
                            verticalSpacing,
                            buildLightRow(
                              'Placed On',
                              state.invoiceInfo.data?.issuedAt?.dateFormatted ??
                                  "-",
                              'تاريخ اصدار الفاتورة',
                            ),
                            verticalSpacing,
                            buildLightRow(
                              'Order no',
                              state.invoiceInfo.data?.requestID.toString() ??
                                  "-",
                              'رقم الطلب',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: padding,
                        width: double.infinity,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildDarkRow(
                                'Supplier name', "value", "اسم المورد"),
                            verticalSpacing,
                            buildDarkRow(
                                'Supplier address', "value", "عنوان المورد"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        color: Colors.black,
                        padding: padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildLightRow(
                              'Nature of the service',
                              'Vat Rate',
                              'Total Taxable amount',
                            ),
                            verticalSpacing,
                            buildLightRow(
                              'تفاصيل الخدمة',
                              'نسبة الضريبة',
                              'الإجمالى الجامع للضريبة',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: padding,
                        child: Column(
                          children: [
                            buildDarkRow(
                              'Medical Service',
                              '${(state.invoiceInfo.data!.vat! / state.invoiceInfo.data!.amount! * 100).toStringAsFixed(0)}%',
                              '${(state.invoiceInfo.data!.vat! / state.invoiceInfo.data!.amount! * 100).toStringAsFixed(0)}%',
                            ),
                            verticalSpacing,
                            const Divider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                            buildDarkRow(
                                'Total taxable amount',
                                'الاجمالى الخاضع للضريبة',
                                state.invoiceInfo.data?.subtotal.toString() ??
                                    "-"),
                            verticalSpacing,
                            buildDarkRow(
                                'VAT amount',
                                'مجموع ضريبة القيمة المضافه',
                                state.invoiceInfo.data?.vat.toString() ?? "-"),
                            verticalSpacing,
                            buildDarkRow(
                                'Total amount',
                                'المجموع',
                                state.invoiceInfo.data?.amount.toString() ??
                                    "-"),
                            verticalSpacing,
                            const Divider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                            verticalSpacing,
                            QrImage(
                              version: QrVersions.auto,
                              size: 100.0,
                              data: jsonEncode(
                                  state.invoiceInfo.data!.requestID!),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const LoadingScreen();
        },
      ),
    );
  }

  Widget buildLightRow(String en, String value, String ar,
      [Color color = Colors.white]) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              en,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
              ),
            )),
        const SizedBox(width: 10),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              ar,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDarkRow(String en, String value, String ar) {
    return buildLightRow(en, value, ar, Colors.black);
  }
}
