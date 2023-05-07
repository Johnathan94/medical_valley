import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userDate = UserDate.fromJson(LocalStorageManager.getUser()!);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 90.w,
          height: 90.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage("https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o="),
            fit: BoxFit.cover
            )
          ),
        ),
        Text(userDate.fullName ?? "" , style: AppStyles.baloo2FontWith700WeightAnd25Size.copyWith(color: whiteColor)  ,)
      ],
    );
  }
}
