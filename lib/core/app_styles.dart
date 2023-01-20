import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_valley/core/app_sizes.dart';

import 'app_colors.dart';

class AppStyles {
  static var baloo2FontWith400WeightAnd32Size = GoogleFonts.baloo2(
    color: blackColor,
    fontSize: text32.sp,
    fontWeight: FontWeight.w400,
  );
  static var baloo2FontWith700WeightAnd28Size = GoogleFonts.baloo2(
    color: whiteColor,
    fontSize: text32.sp,
    fontWeight: FontWeight.w700,
  );

  static var baloo2FontWith400WeightAnd12Size = GoogleFonts.baloo2(
    color: blackColor,
    fontSize: text12.sp,
    fontWeight: FontWeight.w400,
  );

  static var baloo2FontWith400WeightAnd22Size = GoogleFonts.baloo2(
    color: whiteColor,
    fontSize: text22.sp,
    fontWeight: FontWeight.w400,
  );

  static var baloo2FontWith700WeightAnd15Size = GoogleFonts.baloo2(
    color: darkGrey,
    fontSize: text15.sp,
    fontWeight: FontWeight.w700,
  );

  static var baloo2FontWith700WeightAnd15SizeWithPrimaryColor =
      GoogleFonts.baloo2(
    color: primaryColor,
    fontSize: text15.sp,
    fontWeight: FontWeight.w700,
  );

  static var baloo2FontWith500WeightAnd15Size = GoogleFonts.baloo2(
    color: grey,
    fontSize: text15.sp,
    fontWeight: FontWeight.w500,
  );
}
