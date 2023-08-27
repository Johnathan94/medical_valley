import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:rxdart/rxdart.dart';

final BehaviorSubject<int> activeButtonIndex = BehaviorSubject();

class EarlistOptions extends StatefulWidget {
  final Color activeColor = primaryColor;
  final Color notActiveColor = buttonGrey;
  @override
  State<EarlistOptions> createState() => EarlistOptionsState();
}

class EarlistOptionsState extends State<EarlistOptions> {
  void _selectButton(int buttonNumber) {
    activeButtonIndex.sink.add(buttonNumber);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    rearrange();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: activeButtonIndex.stream,
        builder: (context, snapshot) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: options
                  .map((e) => Expanded(
                        child: GestureDetector(
                          onTap: () => _selectButton(e.id),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: activeButtonIndex.hasValue
                                  ? activeButtonIndex.value == e.id
                                      ? widget.activeColor
                                      : widget.notActiveColor
                                  : Colors.green,
                            ),
                            child: Text(
                              e.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: activeButtonIndex.hasValue
                                      ? activeButtonIndex.value == e.id
                                          ? Colors.white
                                          : Colors.black
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        });
  }

  final List<OptionModel> options = [];
  void rearrange() {
    final DateTime now = DateTime.now();
    final int currentHour = now.hour;
    options.clear();
    if (currentHour >= 0 && currentHour < 12) {
      options.add(OptionModel(AppLocalizations.of(context)!.am, 1));
      options.add(OptionModel(AppLocalizations.of(context)!.afternoon, 2));
      options.add(OptionModel(AppLocalizations.of(context)!.pm, 3));
      activeButtonIndex.sink.add(1);
    } else if (currentHour >= 12 && currentHour < 18) {
      options.add(OptionModel(AppLocalizations.of(context)!.afternoon, 2));
      options.add(OptionModel(AppLocalizations.of(context)!.pm, 3));
      options.add(OptionModel(AppLocalizations.of(context)!.am, 1));
      activeButtonIndex.sink.add(2);
    } else {
      options.add(OptionModel(AppLocalizations.of(context)!.pm, 3));
      options.add(OptionModel(AppLocalizations.of(context)!.am, 1));
      options.add(OptionModel(AppLocalizations.of(context)!.afternoon, 2));
      activeButtonIndex.sink.add(3);
    }
  }
}

class OptionModel {
  final String title;
  final int id;

  OptionModel(this.title, this.id);
}
