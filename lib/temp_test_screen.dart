// **** Steps of the payment
// *** -----------------------
// *** 1- Call Api to get invoice id & amount
// *** 2- Set ui configurations for paytabs  ConfigsDetailsModel();
// *** 3- Call Paytabs function to pay (pass configuration in constructor & handle response function as parameter)
// *** 4- Implement handleResponse function [Call GetInvoice to make sure payment is done successfully]
// *** -----------------------

import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';

import 'features/payment/payTabs/index.dart';
import 'features/payment/payTabs/models/configs_details_model.dart';
import 'features/payment/payTabs/models/invoice_details_model.dart';
import 'features/payment/payTabs/models/payment_response_model.dart';

// just an example to show you how to use paytabs and the whole scenario
class TempTestScreen extends StatelessWidget {
  const TempTestScreen({super.key});
  // final int offerId;
  final invoiceID = "a4f0e9d2-3fa9-4e58-d4b3-08dbabea5662";
  _pay() async {
    // ** 1- Call Make Invoice to get (invoice_id, amount) for now => in the future - optional [card number,transaction token, transaction reference]
    final invoiceDetails =
        InvoiceDetailsModel(amount: 250.0, invoiceID: invoiceID);
    // ** 2- Set paytabs configurations
    final payTabsConfigs = ConfigsDetailsModel(
      screenTitle: "'Screen Title'", // Localized String
      currencyCode: "SAR", // must be added, with default SAR value
      merchantCountryCode: "SA", // must be added, with default SA value
      cartDescription: "Cart", //
      showBillingInfo: false, // to set it false, you should add billing details
      billingDetails: BillingDetails(
          "John Smith",
          "email@domain.com",
          "+97311111111",
          "st. 12",
          "eg",
          "dubai",
          "dubai",
          "12345"), // mandatory if you dont wanna show billing info form
      invoiceDetails: invoiceDetails,
      locale: (LocalStorageManager.getCurrentLanguage() == "ar")
          ? PaymentSdkLocale.AR
          : PaymentSdkLocale.EN,
      tokeniseType: null,
      iosThemeConfigurations:
          IOSThemeConfigurations(logoImage: 'assets/logo.png'),
    );
    // ** 3- Call paytabs method to pay [ currently, you can pay with card only, not token or saved card]
    // ** Pass function that handle response [success || fail]
    await PayTabsIndex(payTabsConfigs).payWithCard(_handleResponse, "");
  }

  _handleResponse(PaymentResponseModel responseModel) async {
    if (!responseModel.isSuccess) {
      // handle error // =====
    } else {
      // *** 1- Call Get Invoice to make sure payment is done successfully
      // Check the BE Issue
      // handle success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _pay,
          child: const Text("pay"),
        ),
      ),
    );
  }
}
