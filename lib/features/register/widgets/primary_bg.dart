import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';

class PrimaryBg extends StatelessWidget {
  const PrimaryBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: primaryColor,
    );
  }
}
