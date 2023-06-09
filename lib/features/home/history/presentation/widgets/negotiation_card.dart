import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/home/history/data/negotiations/negotiations_model.dart';
import 'package:medical_valley/features/offers/widgets/offers_options_button.dart';

class NegotiationsCard extends StatelessWidget {
  final NegotiationModel items;
  final Function(int id) onNegotiatePressed, onBookPressed;
  const NegotiationsCard(
      {required this.items,
      required this.onNegotiatePressed,
      required this.onBookPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0xffF2F2F2),
                offset: Offset(2, 2),
                blurRadius: 3,
                spreadRadius: 2)
          ]),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 12, bottom: 12),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                            image: const DecorationImage(
                              image: AssetImage(personImage),
                            )),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xffEB8B17),
                            size: 16,
                          ),
                          Text(
                            "0.0",
                            style: AppStyles
                                .baloo2FontWith400WeightAnd18SizeAndBlack
                                .copyWith(color: const Color(0xffD8D7D9)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items.providerName ?? "",
                          style: AppStyles
                              .baloo2FontWith400WeightAnd18SizeAndBlack,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: primaryColor,
                            ),
                            Expanded(
                                child: Text(
                              items.distanceInMeter.toString(),
                              style: AppStyles
                                  .baloo2FontWith400WeightAnd18SizeAndBlack,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                            Text(
                              "m",
                              style: AppStyles
                                  .baloo2FontWith400WeightAnd18SizeAndBlack,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                "${items.price} RS",
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd18SizeAndBlack
                                    .copyWith(color: whiteColor, fontSize: 14),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () => onNegotiatePressed(items.requestId ?? 0),
                        child: OffersOptionsButton(
                          buttonType: ButtonType.negotiate,
                          title: AppLocalizations.of(context)!.negotiate,
                          isEnabled: true,
                        ))),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () => onBookPressed(items.id ?? 0),
                      child: OffersOptionsButton(
                          buttonType: ButtonType.book,
                          title: AppLocalizations.of(context)!.book,
                          isEnabled: true)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
