import 'package:medical_valley/features/home/home_search_screen/data/models/services_model.dart';

class SearchResult {
  bool? succeeded;
  String? message;
  int? responseCode;
  Data? data;

  SearchResult({this.succeeded, this.message, this.responseCode, this.data});

  SearchResult.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    responseCode = json['responseCode'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['responseCode'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  int? totalPages;
  int? pageSize;
  int? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  List<Service>? results;

  Data(
      {this.currentPage,
        this.totalPages,
        this.pageSize,
        this.totalCount,
        this.hasPrevious,
        this.hasNext,
        this.results});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    hasPrevious = json['hasPrevious'];
    hasNext = json['hasNext'];
    if (json['results'] != null) {
      results = <Service>[];
      json['results'].forEach((v) {
        results!.add( Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['currentPage'] =currentPage;
    data['totalPages'] =totalPages;
    data['pageSize'] =pageSize;
    data['totalCount'] =totalCount;
    data['hasPrevious'] =hasPrevious;
    data['hasNext'] =hasNext;
    if (results != null) {
      data['results'] =results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ServiceDays {
  int? dayId;
  int? serviceId;
  String? dayName;

  ServiceDays({this.dayId, this.serviceId, this.dayName});

  ServiceDays.fromJson(Map<String, dynamic> json) {
    dayId = json['dayId'];
    serviceId = json['serviceId'];
    dayName = json['dayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['dayId'] =dayId;
    data['serviceId'] =serviceId;
    data['dayName'] =dayName;
    return data;
  }
}
