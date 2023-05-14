import 'package:medical_valley/features/home/history/data/reservations/get_reservations_api.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';

abstract class GetReservationsUseCase {
 Future<ReservationsResponse> getReservations(int page , int pageSize);
}

class GetReservationsUseCaseImpl extends GetReservationsUseCase{
  ReservationsClient reservationClient ;

  GetReservationsUseCaseImpl( this.reservationClient);

  @override
  Future<ReservationsResponse> getReservations(int page , int pageSize) async{
  var date = await reservationClient.getReservations(page, pageSize);
 return ReservationsResponse.fromJson(date);
  }



}