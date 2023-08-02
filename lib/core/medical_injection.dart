import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/base_service/dio_manager.dart';
import 'package:medical_valley/core/terms_and_conditions/data/terms_and_conditions_client.dart';
import 'package:medical_valley/core/terms_and_conditions/domain/terms_and_conditions_repo.dart';
import 'package:medical_valley/core/terms_and_conditions/persentation/bloc/terms_and_conditions_bloc.dart';
import 'package:medical_valley/features/auth/login/data/api_service/login_client.dart';
import 'package:medical_valley/features/auth/login/data/repo/login_repo.dart';
import 'package:medical_valley/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:medical_valley/features/auth/phone_verification/data/otp_client.dart';
import 'package:medical_valley/features/auth/phone_verification/domain/verify_otp_use_case.dart';
import 'package:medical_valley/features/auth/phone_verification/persentation/bloc/otp_bloc.dart';
import 'package:medical_valley/features/auth/register/data/api_service/register_client.dart';
import 'package:medical_valley/features/auth/register/data/repo/register_repo.dart';
import 'package:medical_valley/features/auth/register/domain/register_usecase.dart';
import 'package:medical_valley/features/auth/register/presentation/register_bloc/register_bloc.dart';
import 'package:medical_valley/features/home/contact_us/data/api/contact_us_client.dart';
import 'package:medical_valley/features/home/contact_us/domain/contact_us_repo.dart';
import 'package:medical_valley/features/home/contact_us/presentation/contact_us_bloc.dart';
import 'package:medical_valley/features/home/history/data/negotiations/get_negotiations_api.dart';
import 'package:medical_valley/features/home/history/data/requests/get_requets_api.dart';
import 'package:medical_valley/features/home/history/data/reservations/get_reservations_api.dart';
import 'package:medical_valley/features/home/history/domain/get_negotiations_usecase.dart';
import 'package:medical_valley/features/home/history/domain/get_requests_usecase.dart';
import 'package:medical_valley/features/home/history/domain/get_reservations_usecase.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_bloc.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_client.dart';
import 'package:medical_valley/features/home/home_screen/data/repo/book_request_repo.dart';
import 'package:medical_valley/features/home/home_screen/persentation/bloc/book_request_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/data/api/categories_client.dart';
import 'package:medical_valley/features/home/home_search_screen/data/api/packages_client.dart';
import 'package:medical_valley/features/home/home_search_screen/data/api/search_client.dart';
import 'package:medical_valley/features/home/home_search_screen/data/api/services_client.dart';
import 'package:medical_valley/features/home/home_search_screen/domain/get_categories_use_case.dart';
import 'package:medical_valley/features/home/home_search_screen/domain/search_with_keyword.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
import 'package:medical_valley/features/home/notifications/data/api/categories_client.dart';
import 'package:medical_valley/features/home/notifications/domain/get_notification_use_case.dart';
import 'package:medical_valley/features/home/notifications/persentation/screens/bloc/notification_bloc.dart';
import 'package:medical_valley/features/info/data/medical_file_api.dart';
import 'package:medical_valley/features/info/domain/get_medical_file_use_case.dart';
import 'package:medical_valley/features/info/domain/set_medical_file_use_case.dart';
import 'package:medical_valley/features/info/presentation/bloc/medical_file_bloc.dart';
import 'package:medical_valley/features/offers/presentation/data/api_service/negotiate_client.dart';
import 'package:medical_valley/features/offers/presentation/data/api_service/offers_client.dart';
import 'package:medical_valley/features/offers/presentation/data/repo/negotiate_repo.dart';
import 'package:medical_valley/features/offers/presentation/data/repo/offers_repo.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/negotiate/negotiate_bloc.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/offers_bloc.dart';
import 'package:medical_valley/features/profile/data/user_api.dart';
import 'package:medical_valley/features/profile/domain/get_user_use_case.dart';
import 'package:medical_valley/features/profile/domain/update_user_use_case.dart';
import 'package:medical_valley/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:medical_valley/features/welcome_page/splash_bloc.dart';

final getIt = GetIt.instance;

configureDependencies() {
  getIt.registerFactory(() => HistoryBloc(
      GetRequestsUseCaseImpl(UserRequestsClient(DioManager.getDio())),
      GetReservationsUseCaseImpl(ReservationsClient(DioManager.getDio())),
      GetNegotiationsUseCaseImpl(NegotiationsClient(DioManager.getDio()))));
  getIt.registerFactory(() => RegisterBloc(RegisterUseCaseImpl(
      RegisterUserRepoImpl(RegisterClient(DioManager.getDio())))));
  getIt.registerFactory(
      () => BookRequestBloc(BookRequestRepo(BookRequestClient())));
  getIt.registerFactory(
      () => LoginBloc(LoginRepoImpl(LoginClient(DioManager.getDio()))));
  getIt.registerFactory(() => HomeBloc(
      GetCategoriesUseCase(
          CategoriesClient(DioManager.getDio()),
          ServicesClient(DioManager.getDio()),
          PackagesClient(DioManager.getDio())),
      SearchWithKeyboard(SearchClient(DioManager.getDio()))));
  getIt.registerFactory(
      () => OffersBloc(OffersRepoImpl(OffersClient(DioManager.getDio()))));
  getIt.registerFactory(() => SplashBloc());
  getIt.registerFactory(() =>
      NegotiateBloc(NegotiateRepoImpl(NegotiateClient(DioManager.getDio()))));
  getIt.registerFactory(() => TermsAndConditionsBloc(
      TermsAndConditionsImpl(TermsAndConditionsClient(DioManager.getDio()))));
  getIt.registerFactory(() =>
      ContactUsBloc(ContactUsRepoImpl(ContactUsClient(DioManager.getDio()))));
  getIt.registerFactory(
      () => OtpBloc(VerifyOtpUseCaseImpl(OtpClient(DioManager.getDio()))));
  getIt.registerFactory(() => MedicalFileBloc(
      GetMedicalFileUseCaseImpl(MedicalFileClient(DioManager.getDio())),
      SetMedicalFileUseCaseImpl(MedicalFileClient(DioManager.getDio()))));
  getIt.registerFactory(() => NotificationBloc(
      GetNotificationUseCaseImpl(NotificationClient(DioManager.getDio()))));
  getIt.registerFactory(() => UserProfileBloc(
      GetUserUseCaseImpl(UserClient(DioManager.getDio())),
      UpdateUserUseCaseImpl((UserClient(DioManager.getDio())))));
}
