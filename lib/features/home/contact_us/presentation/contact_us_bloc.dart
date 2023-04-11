import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/home/contact_us/data/model/contact_us_response_model.dart';
import 'package:medical_valley/features/home/contact_us/domain/contact_us_repo.dart';

class ContactUsBloc extends Cubit<ContactUsState >{
  ContactUsBloc(this.contactRepo): super(ContactUsStateIdle());
  ContactUsRepo contactRepo ;
  void contactUs (ContactUsEvent event )async{
    emit(ContactUsStateLoading());
    var loginUser = await contactRepo.contactUs(event.model);
    loginUser.fold(
            (l) {
          emit(ContactUsStateError());
        }, (r) {
      emit(ContactUsStateSuccess());
    }
    );
  }


}
class ContactUsEvent{
  ContactUsModel model ;

  ContactUsEvent(this.model);
}
abstract class ContactUsState{}
 class ContactUsStateIdle extends ContactUsState{}
 class ContactUsStateLoading extends ContactUsState{}
 class ContactUsStateError extends ContactUsState{}
 class ContactUsStateSuccess extends ContactUsState{}