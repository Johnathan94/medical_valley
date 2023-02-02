import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/payment_data.dart';
import 'package:awesome_card/awesome_card.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  initState() {
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            addPaymentTitle(),
            cardImage(),
            otherCards(),
            confirmButton()
          ],
        ),
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
      child:CreditCard(
          cardNumber: "5450 7879 4864 7854",
          cardExpiry: "10/25",
          cardHolderName: "Card Holder",
          cvv: "456",
          bankName: "Axis Bank",
          cardType: CardType.other, // Optional if you want to override Card Type
          showBackSide: false,
          frontBackground: Container(color: primaryColor,),
          backBackground: Container(color: primaryColor,),
          showShadow: true,
          textExpDate: 'Exp. Date',
          textName: 'Name',
          textExpiry: 'MM/YY'
      ),
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
      child: PrimaryButton(text: AppLocalizations.of(context)!.confirm),
    );
  }

  var value;

  buildPaymentItem(PaymentData payment, int index) {
    print(payment.icon);
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
              child: Image.asset(payment.icon,width: 30,height: 30,)),
          const SizedBox(width: 8,),
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
