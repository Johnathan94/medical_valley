import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:medical_valley/features/payment/payTabs/models/configs_details_model.dart';

import '../constants/constants.dart';

class PayTabsConfigs {
  PayTabsConfigs._();

  static PaymentSdkConfigurationDetails getConfigs(ConfigsDetailsModel configs) {
    return PaymentSdkConfigurationDetails(
      profileId: PayTabsConstants.profileId,
      serverKey: PayTabsConstants.serverId,
      clientKey: PayTabsConstants.clientId,
      cartId: configs.invoiceDetails.invoiceID,
      cartDescription: configs.cartDescription,
      merchantName: configs.merchantName,
      screentTitle: configs.screenTitle,
      amount: configs.invoiceDetails.amount,
      locale: configs.locale,
      currencyCode: configs.currencyCode,
      merchantCountryCode: configs.merchantCountryCode,
      billingDetails: configs.billingDetails,
      shippingDetails: configs.shippingDetails,
      isDigitalProduct: false,
      hideCardScanner: true,
      simplifyApplePayValidation: false,
      showShippingInfo: false,
      showBillingInfo: configs.showBillingInfo,
      enableZeroContacts: false,
      linkBillingNameWithCardHolderName: false,
      tokeniseType: configs.tokeniseType,
      iOSThemeConfigurations: configs.iosThemeConfigurations,
    );
  }
}
