import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'custom_app_bar.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);
}

abstract class BaseStatefulWidgetState extends State<BaseStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          header: "Medical file",
          leadingIcon: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
            ),
          ),
        ),
        body: getScreenBody());
  }

  getScreenBody();
}
