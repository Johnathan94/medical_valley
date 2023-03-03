
import 'package:medical_valley/core/app_colors.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoadingDialogs {
 static late SimpleFontelicoProgressDialog _dialog ;

  static showLoadingDialog(context)async{
    _dialog =
    SimpleFontelicoProgressDialog(context: context,barrierDimisable: true);
    _dialog.show(message: AppLocalizations.of(context)!.loading, type: SimpleFontelicoProgressDialogType.normal,indicatorColor: primaryColor,);
  }
  static hideLoadingDialog(){
    _dialog.hide();
  }
}