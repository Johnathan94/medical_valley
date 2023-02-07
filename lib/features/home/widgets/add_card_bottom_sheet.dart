import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/formatter/card_number_formatter.dart';
import 'package:medical_valley/core/formatter/expiry_date_formatter.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';

class AddCardBottomSheet extends StatelessWidget {
  const AddCardBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      padding: bigPaddingHV,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: const [
          BoxShadow(
              offset: Offset(2, 1),
              blurRadius: 5,
              spreadRadius: 1,
              color: shadowGrey)
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.add_new_card,
                style: AppStyles.baloo2FontWith400WeightAnd20Size
                    .copyWith(color: blackColor),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: blackColor,
                  )),
            ],
          ),
          SizedBox(
            height: 23.h,
          ),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberFormatter(),
            ],
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counter: const Offstage(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/800px-Mastercard-logo.svg.png',
                  height: 30,
                  width: 30,
                ),
              ),
              border:  const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
              hintText: 'XXXX XXXX XXXX XXXX',
              labelText: AppLocalizations.of(context)!.card_number,
            ),
            maxLength: 19,

            onChanged: (value) {},
          ),
          SizedBox(
            height: 14.h,
          ),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardExpirationFormatter()
            ],
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration:  InputDecoration(
              counter: const Offstage(),
              prefixIcon:const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Icon(Icons.date_range , color: primaryColor,)
              ),
              border:const  UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
              hintText: 'XX / XX',
              labelText: AppLocalizations.of(context)!.expiry_date,
            ),
            maxLength: 5,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 14.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration:  InputDecoration(
              counter: const Offstage(),
              prefixIcon:const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Icon(Icons.person , color: primaryColor,)
              ),
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
              hintText: AppLocalizations.of(context)!.name,
              labelText:AppLocalizations.of(context)!.card_name,
            ),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 14.h,
          ),
      TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration:  InputDecoration(
              counter:  const Offstage(),
              prefixIcon:const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Icon(Icons.food_bank_outlined , color: primaryColor,)
              ),
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
              hintText: 'XXX',
              labelText: AppLocalizations.of(context)!.cvv,
            ),
            maxLength: 3,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 14.h,
          ),
      Padding(
        padding: const EdgeInsetsDirectional.only(top: 10.0, start: 20, end: 20),
        child: PrimaryButton(text: AppLocalizations.of(context)!.add_card, onPressed: (){

        },),
      )
        ],
      ),
    );
  }
}
