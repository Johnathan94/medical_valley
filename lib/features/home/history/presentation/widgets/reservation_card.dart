import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';
import 'package:medical_valley/features/home/history/presentation/history_screen.dart';

class ReservationsCard extends StatelessWidget {
  final ReservationModel item;

  const ReservationsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
            const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: smallPaddingHV,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            style:
                            AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
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
                ),
                Text(
                  item.bookingStatusStr ?? "",
                  style: AppStyles
                      .baloo2FontWith400WeightAnd18SizeAndBlack,
                ),
              ],
            ),
          ),
          const AppointmentTypeView(),
          const SizedBox(height: 15,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xffF9F9F9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.location_pin,
                  color: primaryColor,
                ),
                Text(
                  item.providerLocation ?? "",
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),

        ],
      ),
    );
  }
}
