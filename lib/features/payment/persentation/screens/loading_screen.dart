import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:rxdart/rxdart.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  late Timer? colorChangeTimer;
  final BehaviorSubject<Color> loadingColor =
      BehaviorSubject.seeded(Colors.blue);

  @override
  void initState() {
    super.initState();
    // Start the timer to change the loading color every 1 second
    colorChangeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      loadingColor.sink.add(_getRandomColor());
    });
  }

  @override
  void dispose() {
    colorChangeTimer?.cancel();
    super.dispose();
  }

  Color _getRandomColor() {
    List<Color> colors = [
      primaryColor,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];
    return colors[DateTime.now().second % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<Color>(
                stream: loadingColor.stream,
                builder: (context, snapshot) {
                  return AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: loadingColor.value,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.getting_invoice_state,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
