import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/features/home/home_screen/persentation/screens/home_screen.dart';
import 'package:medical_valley/features/home/widgets/home_base_stateful_widget.dart';
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green
              ),
            height: 130,
              width: 130,
              alignment: Alignment.center,
              child: const Icon(Icons.done_all,color: Colors.white,size: 60,),
            ),
            const SizedBox(height: 12,),
             Text(AppLocalizations.of(context)!.booking_confirmed,style: AppStyles.baloo2FontWith700WeightAnd22Size.copyWith(color: blackColor),),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>const HomeBaseStatefulWidget()),
                        (route) =>false
                );
              },
              child: Text(AppLocalizations.of(context)!.go_to_home),
            ),
          ],
        ),
      ),
    );
  }
}
