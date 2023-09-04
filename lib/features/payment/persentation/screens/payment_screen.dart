import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/payment/data/make_invoice_response.dart';
import 'package:medical_valley/features/payment/data/user_card_model.dart';
import 'package:medical_valley/features/payment/persentation/invoice_bloc/invoice_bloc.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/payment_data.dart';

class PaymentScreen extends StatefulWidget {
  final int offerId;

  const PaymentScreen({required this.offerId, Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  UserCard? userCard;
  InvoiceBloc _invoiceBloc = GetIt.instance<InvoiceBloc>();

  @override
  initState() {
    _invoiceBloc.createInvoice(widget.offerId);
    userCard = LocalStorageManager.getUserCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocBuilder<InvoiceBloc, InvoiceState>(
        bloc: _invoiceBloc,
        builder: (context, state) {
          if (state is LoadingCreationInvoiceState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessCreationInvoiceState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*Padding(
            padding: const EdgeInsetsDirectional.only(start: 42, end: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.saved_cards,
                  style: AppStyles.baloo2FontWith600WeightAnd22Size,
                ),
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) => AddCardBottomSheet());
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                        Text(
                          AppLocalizations.of(context)!.add_new_card,
                          style: AppStyles.baloo2FontWith600WeightAnd16Size,
                        )
                      ],
                    ),
                  );
                })
              ],
            ),
          ),*/
                //cardImage(),

                otherCards(),
                _buildSheet(state.makeInvoiceResponse)
                //confirmButton()
              ],
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.something_went_wrong),
            );
          }
        },
      ),
    );
  }

  buildAppBar(ctx) {
    return MyCustomAppBar(
      header: AppLocalizations.of(context)!.payment,
      leadingIcon: InkWell(
        onTap: () {
          Navigator.pop(ctx);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
        ),
      ),
    );
  }

  cardImage() {
    return Container(
      margin: const EdgeInsets.only(top: 19),
      alignment: AlignmentDirectional.center,
      child: CreditCard(
          cardNumber: userCard?.cardNumber ?? " ",
          cardExpiry: userCard?.expiryDate ?? " ",
          cardHolderName: userCard?.cardHolderName ?? " ",
          cvv: userCard?.cvv ?? " ",
          bankName: "",
          cardType: CardType.other,
          // Optional if you want to override Card Type
          showBackSide: false,
          frontBackground: Container(
            color: primaryColor,
          ),
          backBackground: Container(
            color: primaryColor,
          ),
          showShadow: true,
          textExpDate: 'Exp. Date',
          textName: 'Name',
          textExpiry: 'MM/YY'),
    );
  }

  Widget otherCards() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20, start: 20, end: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [otherCardsTitle(), buildOtherPayment()],
      ),
    );
  }

  otherCardsTitle() {
    return Text(
      AppLocalizations.of(context)!.other_payment_option,
      style: AppStyles.baloo2FontWith500WeightAnd22Size,
    );
  }

  buildOtherPayment() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: AppInitializer.paymentMethods.length,
        itemBuilder: (context, index) {
          return buildPaymentItem(AppInitializer.paymentMethods[index], index);
        });
  }

  confirmButton(MakeInvoiceResponse item) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 15.0,
        start: 10,
        end: 10,
        bottom: 15.0,
      ),
      child: PrimaryButton(
        text: AppLocalizations.of(context)!.payment,
        onPressed: () {
          var billingDetails = BillingDetails(
              "John smith",
              "mohamedimbaby999@gmail.com",
              "01097833162",
              "address line",
              "eg",
              "cairo",
              "state",
              "zip code");
          List<PaymentSdkAPms> apms = [];
          apms.add(PaymentSdkAPms.AMAN);

          var configuration = PaymentSdkConfigurationDetails(
              profileId: "96752",
              clientKey: "CNKMB6-6N6T6T-V27Q9G-GPVT76",
              serverKey: "SGJNDZT9R9-JGWBTNZ6R6-KGGKMBTJR2",
              cartDescription: "cart desc",
              merchantName: "Medical Valley",
              screentTitle: "Pay with Card",
              billingDetails: billingDetails,
              locale: PaymentSdkLocale.EN,
              //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
              amount: item.data?.totalPaid,
              currencyCode: "SAR",
              merchantCountryCode: "SA",
              linkBillingNameWithCardHolderName: true,
              showBillingInfo: false);

          configuration.tokeniseType = PaymentSdkTokeniseType.NONE;
          var theme = IOSThemeConfigurations();
          theme.logoImage = "assets/logo.png";
          configuration.iOSThemeConfigurations = theme;

          try {
            FlutterPaytabsBridge.startCardPayment(configuration, (event) {
              print(event);

              if (event["status"] == "success") {
                var transactionDetails = event["data"];
                print(transactionDetails);

                if (transactionDetails["isSuccess"]) {
                  print("successful transaction");
                } else {
                  print("failed transaction");
                }
              } else if (event["status"] == "error") {
                // Handle error here.
              } else if (event["status"] == "event") {
                print(event["message"]);
              }
            });
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }

  var value;

  buildPaymentItem(PaymentData payment, int index) {
    return RadioListTile(
      activeColor: primaryColor,
      controlAffinity: ListTileControlAffinity.trailing,
      value: index,
      groupValue: value,
      onChanged: (newValue) => setState(() => value = newValue),
      title: Row(
        children: [
          Container(
              width: 30,
              height: 30,
              child: Image.asset(
                payment.icon,
                width: 30,
                height: 30,
              )),
          const SizedBox(
            width: 8,
          ),
          Text(
            payment.name,
            style: AppStyles.baloo2FontWith500WeightAnd22Size,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildSheet(MakeInvoiceResponse item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.6),
                spreadRadius: 5,
                blurRadius: 3,
                offset: const Offset(0, 4))
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.tax,
                style: AppStyles.baloo2FontWith400WeightAnd20Size
                    .copyWith(color: Colors.black),
              ),
              Text(
                "${item.data?.vat}",
                style: AppStyles.baloo2FontWith400WeightAnd20Size
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.subtotal,
                style: AppStyles.baloo2FontWith400WeightAnd20Size
                    .copyWith(color: Colors.black),
              ),
              Text(
                "${item.data?.subtotal}",
                style: AppStyles.baloo2FontWith400WeightAnd20Size
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.total,
                style: AppStyles.baloo2FontWith400WeightAnd20Size
                    .copyWith(color: Colors.black),
              ),
              Text(
                "${item.data?.totalPaid}",
                style: AppStyles.baloo2FontWith400WeightAnd20Size
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
          confirmButton(item)
        ],
      ),
    );
  }
}
