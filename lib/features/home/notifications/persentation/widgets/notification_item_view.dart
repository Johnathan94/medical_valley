import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/home/notifications/data/models/notification_model.dart';
import 'package:medical_valley/features/home/notifications/persentation/widgets/circle_image_view.dart';

class NotificationView extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationView({required this.notificationModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSlidableWidget();
  }

  buildView() {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: greyWith80Percentage,
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(1, 1))
      ], color: whiteColor, borderRadius: BorderRadius.circular(13)),
      padding: smallPaddingHV,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: smallPaddingT,
            child: CircleImageView(
                width: 60.h,
                height: 40.h,
                url:
                    "https://www.shutterstock.com/image-photo/man-hands-holding-global-network-260nw-1801568002.jpg"),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notificationModel.providerName ?? "",
                      style: AppStyles.baloo2FontWith600WeightAnd18Size
                          .copyWith(color: blackColor),
                    ),
                    Text(
                      notificationModel.notificationActionStr ?? "",
                      style: AppStyles.baloo2FontWith400WeightAnd12Size,
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.h,
                ),
                Text(
                  LocalStorageManager.getCurrentLanguage() == "ar"
                      ? notificationModel.arabicText ?? ""
                      : notificationModel.englishText ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppStyles.baloo2FontWith500WeightAnd15Size
                      .copyWith(color: textGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildSlidableWidget() {
    return Padding(
      padding: bigPaddingH.copyWith(top: 7.h, bottom: 7.h),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          extentRatio: .28,
          closeThreshold: .1,
          motion: const DrawerMotion(),
          children: [],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: buildView(),
      ),
    );
  }
}
