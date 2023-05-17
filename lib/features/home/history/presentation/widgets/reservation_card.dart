import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/extensions/string_extensions.dart';
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
        height: 200.h,
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
                              "4.2",
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
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.providerName ?? "",
                            style: AppStyles
                                .baloo2FontWith400WeightAnd18SizeAndBlack,
                          ),
                          const SizedBox(height: 2),
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
                                    style: AppStyles
                                        .baloo2FontWith400WeightAnd18Size
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
                                    style: AppStyles
                                        .baloo2FontWith400WeightAnd14Size
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
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd18SizeAndBlack,
                              ),
                              const Text("-"),
                              Text(
                                item.periodEndTime ?? "",
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd18SizeAndBlack,
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          item.bookingTypeId!
                              .getBookingStatus(item.bookingTypeStr!)
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                              item.offerDate ?? "",
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
                                "${item.price} RS",
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
            ),
          ],
        ),
      ),
    );
  }
}
