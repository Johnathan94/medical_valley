import 'dart:async';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:medical_valley/features/payment/payTabs/models/payment_response_model.dart';

import 'configs/configs.dart';
import 'models/configs_details_model.dart';

class PayTabsIndex {
  PaymentSdkConfigurationDetails? _paymentSdkConfigDetails;
  PayTabsIndex(ConfigsDetailsModel configsDetailsModel) {
    _paymentSdkConfigDetails = PayTabsConfigs.getConfigs(configsDetailsModel);
  }

  Future<void> payWithCard(Function handleResponse) async {
    await FlutterPaytabsBridge.startCardPayment(_paymentSdkConfigDetails!, (event) async {
      var status = event["status"];
      var response = PaymentResponseModel(isSuccess: false, status: status);
      if (status == "success") {
        var transactionDetails = event["data"];
        response = PaymentResponseModel(
          isSuccess: transactionDetails['isSuccess'],
          status: status,
        );
      }
      await handleResponse(response);
    });
  }
}
