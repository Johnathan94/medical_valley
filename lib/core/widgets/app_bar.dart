import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';

class CustomAppBar extends AppBar {
  String header ;
  Icon leadingIcon ;
  List<Widget>? appBarActions ;
   CustomAppBar({required this.header ,required this.leadingIcon ,this.appBarActions , Key? key}) : super(key: key,
    title: Text(header , style: AppStyles.baloo2FontWith700WeightAnd28Size,),
     leading: leadingIcon,
     elevation: 0,
     actions: appBarActions ?? [],
     backgroundColor: primaryColor
  );


}


