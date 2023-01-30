import 'package:medical_valley/features/home/data/models/sub_services_model.dart';

class ServiceModel {
  final int id;
  final String name;
  final List<SubServices> subServices;

  ServiceModel(this.id, this.name, this.subServices);
}
