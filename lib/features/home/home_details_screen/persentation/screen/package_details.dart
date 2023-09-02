import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';

class PackageDetails extends StatelessWidget {
  const PackageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.packages),
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: const [
                  BoxShadow(spreadRadius: 1, blurRadius: 8, color: shadowColor)
                ],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 12, bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                                image: const DecorationImage(
                                  image: AssetImage(personImage),
                                )),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xffEB8B17),
                                size: 16,
                              ),
                              Text(
                                "4.2",
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd18SizeAndBlack
                                    .copyWith(color: const Color(0xffD8D7D9)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Provider name",
                              style: AppStyles
                                  .baloo2FontWith400WeightAnd18SizeAndBlack
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "From 12/12/2012 - 12/12/2013",
                              style: AppStyles.baloo2FontWith400WeightAnd14Size,
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: [1, 2, 3]
                                  .map((e) => const Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text("-data"),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 10),
                            const Text("Specialist")
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "Price ${AppLocalizations.of(context)!.sr}",
                              style: AppStyles
                                  .baloo2FontWith400WeightAnd18SizeAndBlack
                                  .copyWith(color: whiteColor, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    AppLocalizations.of(context)!.book,
                    style: AppStyles.baloo2FontWith400WeightAnd18Size
                        .copyWith(color: whiteColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
