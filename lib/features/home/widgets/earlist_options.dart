import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:rxdart/rxdart.dart';

class EarlistOptions extends StatelessWidget {
  final BehaviorSubject<int> activeButtonIndex = BehaviorSubject.seeded(1);
  final Color activeColor = primaryColor;
  final Color notActiveColor = buttonGrey;

  EarlistOptions({super.key}) {
    rearrange();
  }
  void _selectButton(int buttonNumber) {
    activeButtonIndex.sink.add(buttonNumber);
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
                              color: activeButtonIndex.value == e.id
                                  ? activeColor
                                  : notActiveColor,
                            ),
                            child: Text(
                              e.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: activeButtonIndex.value == e.id
                                      ? Colors.white
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
      options.add(OptionModel("AM", 1));
      options.add(OptionModel("Afternoon", 2));
      options.add(OptionModel("PM", 3));
    } else if (currentHour >= 12 && currentHour < 5) {
      options.add(OptionModel("Afternoon", 2));
      options.add(OptionModel("PM", 3));
      options.add(OptionModel("AM", 1));
    } else {
      options.add(OptionModel("PM", 3));
      options.add(OptionModel("AM", 1));
      options.add(OptionModel("Afternoon", 2));
    }
  }
}

class OptionModel {
  final String title;
  final int id;

  OptionModel(this.title, this.id);
}
