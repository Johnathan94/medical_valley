import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/widgets/custom_app_bar.dart';
import 'package:medical_valley/main.dart';

import 'package:rxdart/rxdart.dart';

import '../../data/models/language_model.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  final BehaviorSubject<LanguageModel> _languages = BehaviorSubject();

  @override
  initState() {
    var currentLanguage = LocalStorageManager.getCurrentLanguage();
    switch(currentLanguage){
      case "":
        lang = [
          LanguageModel(0 ,"English ", "English Language", true),
          LanguageModel(1 ,"Arabic ", "اللغه العربيه", false ),
        ];
        break ;
      case "en":
        lang = [
          LanguageModel(0 ,"English ", "English Language", true ),
          LanguageModel(1 ,"Arabic ", "اللغه العربيه", false ),
        ];
        break ;
      case "ar":
        lang = [
          LanguageModel(0 ,"English ", "English Language", false ),
          LanguageModel(1 ,"Arabic ", "اللغه العربيه", true ),
        ];
        break ;
    }
    _languages.sink.add(lang.first);
    super.initState();
  }

  @override
  dispose() {
    _languages.stream.drain();
    _languages.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    return MyCustomAppBar(
        header: AppLocalizations.of(context)!.language_title,
        leadingIcon: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ));
  }

  getBody() {
    return StreamBuilder<LanguageModel>(
        stream: _languages.stream,
        builder: (context, snapshot) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: lang.length,
              padding:
              const EdgeInsetsDirectional.only(start: 25, end: 25, top: 18),
              itemBuilder: (context, index) {
                return buildLangItem(lang[index]);
              });
        });
  }

  buildLangItem(LanguageModel language) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Column(
        children: [
          InkWell(
            onTap: () async{
              await changeLanguage(language);
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(language.title),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(language.subTitle),
                    ),
                  ],
                ),
                language.checked
                    ? Container(
                  decoration: const BoxDecoration(
                      color: greenCheckBox,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                )
                    : Container()
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(top: 10, end: 15.0),
            child: Divider(
              height: 0.4,
              color: dividerColor,
            ),
          )
        ],
      ),
    );
  }
  List<LanguageModel> lang = [];
  changeLanguage(LanguageModel language) async{
    if(!language.checked) {
      for (var e in lang) {
        e.checked = !e.checked;
      }
      _languages.sink.add(language);
      var nextLocale = getNextLocale(language);
      await LocalStorageManager.saveCurrentLanguage(nextLocale.languageCode);
      languageBloc.changeLanguage(nextLocale);
    }
  }
  Locale getNextLocale (LanguageModel language){
    return language.id == 1 ?
    const Locale("ar") :
    const Locale("en");
  }
}
