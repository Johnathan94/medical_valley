import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../strings/images.dart';
import '../terms_and_conditions/persentation/screens/terms_and_condition_screen.dart';
import 'base_stateful_widget.dart';

class Error404Screen extends BaseStatefulWidget {
  const Error404Screen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NoInternetConnectionState();
}

class NoInternetConnectionState extends BaseStatefulWidgetState {
  @override
  getScreenBody() {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const TermsAndConditionsScreen())),
      child: Container(
        alignment: AlignmentDirectional.center,
        child: SvgPicture.asset(error404Icon),
      ),
    );
  }
}
