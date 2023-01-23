import 'package:flutter/material.dart';

import '../strings/images.dart';
import 'base_stateful_widget.dart';

class Error404Screen extends BaseStatefulWidget {
  const Error404Screen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NoInternetConnectionState();
}

class NoInternetConnectionState extends BaseStatefulWidgetState {
  @override
  getScreenBody() {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Image.asset(noInternetIcon),
    );
  }
}
