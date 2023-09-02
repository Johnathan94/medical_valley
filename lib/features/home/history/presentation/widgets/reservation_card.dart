import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/extensions/string_extensions.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';
import 'package:medical_valley/features/home/history/presentation/reservation_details.dart';

class ReservationsCard extends StatelessWidget {
  final ReservationModel item;

  const ReservationsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => ReservationsDetails(
                    item: item,
                  ))),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  ),*/
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.providerName ?? "",
                    style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Column(
                        children: const [
                          Icon(
                            Icons.circle,
                            color: Colors.grey,
                            size: 10,
                          ),
                          DottedLine(
                            direction: Axis.vertical,
                            lineLength: 20,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: primaryColor,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                          Icon(
                            Icons.circle,
                            color: primaryColor,
                            size: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.categoryStr ?? "",
                            style: AppStyles.baloo2FontWith400WeightAnd18Size
                                .copyWith(
                              color: textGrey,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            LocalStorageManager.getCurrentLanguage() == "ar"
                                ? item.serviceStrAr ?? ""
                                : item.serviceStr ?? "",
                            style: AppStyles.baloo2FontWith400WeightAnd14Size
                                .copyWith(color: primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        item.periodStartTime ?? "",
                        style:
                            AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                      ),
                      const Text("-"),
                      Text(
                        item.periodEndTime ?? "",
                        style:
                            AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  item.bookingTypeId!.getBookingStatus(item.bookingTypeStr!)
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    item.offerDate != null
                        ? Text(
                            item.offerDate!.dateFormatted!,
                            style: AppStyles
                                .baloo2FontWith400WeightAnd18SizeAndBlack,
                          )
                        : Text(
                            AppLocalizations.of(context)!.there_is_no_date,
                            style: AppStyles
                                .baloo2FontWith400WeightAnd18SizeAndBlack,
                          ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        "${item.price} ${AppLocalizations.of(context)!.sr}",
                        style: AppStyles
                            .baloo2FontWith400WeightAnd18SizeAndBlack
                            .copyWith(color: whiteColor, fontSize: 14),
                      ),
                    )
                  ],
                )),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
