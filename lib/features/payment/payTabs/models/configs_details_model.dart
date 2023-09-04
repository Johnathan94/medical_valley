import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:medical_valley/features/payment/payTabs/models/invoice_details_model.dart';

class ConfigsDetailsModel {
  final String? screenTitle;
  final String? screenLogo;
  final PaymentSdkLocale? locale;
  final String? currencyCode;
  final String? merchantCountryCode;
  final String? merchantName;
  final String cartDescription;

  final ShippingDetails? shippingDetails;
  final BillingDetails? billingDetails;
  final bool? showBillingInfo;
  final PaymentSdkTokeniseType? tokeniseType;
  final IOSThemeConfigurations? iosThemeConfigurations;
  final InvoiceDetailsModel invoiceDetails;

  ConfigsDetailsModel({
    this.screenTitle,
    this.screenLogo,
    this.locale = PaymentSdkLocale.EN,
    this.currencyCode = "SAR",
    this.merchantCountryCode = "SA",
    this.shippingDetails,
    this.merchantName,
    this.cartDescription = "Cart", //required
    this.billingDetails,
    this.showBillingInfo,
    this.tokeniseType,
    this.iosThemeConfigurations,
    required this.invoiceDetails,
  });
}
