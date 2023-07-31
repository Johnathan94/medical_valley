import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/home/widgets/add_card_bottom_sheet.dart';
import 'package:medical_valley/features/payment/data/user_card_model.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/payment_data.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  UserCard? userCard;
  @override
  initState() {
    userCard = LocalStorageManager.getUserCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: whiteColor,
        padding: const EdgeInsetsDirectional.only(top: 38),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
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
              ),
              cardImage(),
              otherCards(),
              confirmButton()
            ],
          ),
        ),
      ),
    );
  }

  buildAppBar() {
    return MyCustomAppBar(
      header: AppLocalizations.of(context)!.payment,
      leadingIcon: InkWell(
        onTap: () {
          Navigator.pop(context);
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
          cardType:
              CardType.other, // Optional if you want to override Card Type
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

  otherCards() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 70, start: 29, end: 33),
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

  confirmButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10.0, start: 35, end: 35),
      child: PrimaryButton(
        text: AppLocalizations.of(context)!.confirm,
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
            clientKey: "C9KMB6-6N2M6T-V27Q9G-GMD9VK",
            serverKey: "STJNDZT9D9-JGWBTNZ6GK-L2DTDKNTKT",
            cartDescription: "cart desc",
            merchantName: "Medical Valley",
            screentTitle: "Pay with Card",
            billingDetails: billingDetails,
            locale: PaymentSdkLocale
                .EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
            amount: 12.3,
            currencyCode: "EGP",
            merchantCountryCode: "EG",
            linkBillingNameWithCardHolderName: true,
            alternativePaymentMethods: apms,
          );

          configuration.tokeniseType =
              PaymentSdkTokeniseType.MERCHANT_MANDATORY;
          configuration.showBillingInfo = true;
          var theme = IOSThemeConfigurations();
          theme.logoImage = "assets/logo.png";
          configuration.iOSThemeConfigurations = theme;

          try {
            FlutterPaytabsBridge.startCardPayment(configuration, (event) {
              print(event);

              if (event["status"] == "success") {
                // Handle transaction details here.
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
      activeColor: blackColor,
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
}
