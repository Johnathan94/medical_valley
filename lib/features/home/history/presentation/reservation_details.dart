import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReservationsDetails extends StatelessWidget {
  final ReservationModel item;
  const ReservationsDetails({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.reservations),
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.close,
            color: whiteColor,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(color: whiteColor, boxShadow: [
          BoxShadow(
              color: darkGrey.withOpacity(.05),
              blurRadius: 3,
              spreadRadius: 5,
              offset: const Offset(2, 3)),
        ]),
        child: Column(
          children: [
            Row(
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
                const SizedBox(width: 16),
                Text(
                  item.providerName ?? "",
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          lineLength: 30,
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
                      width: 8,
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
                          height: 16,
                        ),
                        Text(
                          item.serviceStr ?? "",
                          style: AppStyles.baloo2FontWith400WeightAnd14Size
                              .copyWith(color: primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.time,
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack
                      .copyWith(color: blackColor, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      item.periodStartTime ?? "",
                      style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack
                          .copyWith(
                              color: blackColor, fontWeight: FontWeight.bold),
                    ),
                    const Text("-"),
                    Text(
                      item.periodEndTime ?? "",
                      style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack
                          .copyWith(
                              color: blackColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            item.offerDate != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.date,
                        style: AppStyles
                            .baloo2FontWith400WeightAnd18SizeAndBlack
                            .copyWith(
                                color: blackColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item.offerDate ?? "",
                        style: AppStyles
                            .baloo2FontWith400WeightAnd18SizeAndBlack
                            .copyWith(
                                color: blackColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.branch,
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack
                      .copyWith(color: blackColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  item.providerBranchName ?? "",
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack
                      .copyWith(color: blackColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.booking_type,
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack
                      .copyWith(color: blackColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  item.bookingTypeStr ?? "",
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack
                      .copyWith(color: blackColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.total_price,
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack
                      .copyWith(color: blackColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  item.price.toString(),
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack
                      .copyWith(color: blackColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 50),
            QrImage(
              version: QrVersions.auto,
              size: 200.0,
              data: item.exportToQr(),
            ),
          ],
        ),
      ),
    );
  }
}
