import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/strings/images.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/payment_data.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<PaymentData> _payments = [];

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _payments
          .add(PaymentData(1, AppLocalizations.of(context)!.visa, visaIcon));
      _payments.add(
          PaymentData(2, AppLocalizations.of(context)!.paypal, paypalIcon));
      _payments.add(PaymentData(
          3, AppLocalizations.of(context)!.google_pay, googlePayIcon));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildPaymentBody(),
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

  buildPaymentBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: whiteColor,
      padding: const EdgeInsetsDirectional.only(top: 38),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          addPaymentTitle(),
          cardImage(),
          otherCards(),
          confirmButton()
        ],
      ),
    );
  }

  addPaymentTitle() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 42, end: 21),
      child: Row(
        children: [
          Text(
            AppLocalizations.of(context)!.saved_cards,
            style: AppStyles.baloo2FontWith600WeightAnd22Size,
          ),
          const Spacer(),
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
  }

  cardImage() {
    return Container(
      margin: const EdgeInsets.only(top: 19),
      alignment: AlignmentDirectional.center,
      child: SvgPicture.asset(paymentCardIcon),
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
        shrinkWrap: true,
        itemCount: _payments.length,
        itemBuilder: (context, index) {
          return buildPaymentItem(_payments[index], index);
        });
  }

  confirmButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 90.0, start: 35, end: 35),
      child: PrimaryButton(text: AppLocalizations.of(context)!.confirm),
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
          SvgPicture.asset(payment.icon),
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
