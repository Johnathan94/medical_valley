class ServicesResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Services? data;

  ServicesResponse(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ?  Services.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['messageCode'] = messageCode;
    data['responseCode'] = responseCode;
    data['validationIssue'] = validationIssue;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Services {
  int? currentPage;
  int? totalPages;
  int? pageSize;
  int? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  List<Service>? results;

  Services(
      {this.currentPage,
        this.totalPages,
        this.pageSize,
        this.totalCount,
        this.hasPrevious,
        this.hasNext,
        this.results});

  Services.fromJson(Map<String, dynamic> json) {
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
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['pageSize'] = pageSize;
    data['totalCount'] = totalCount;
    data['hasPrevious'] = hasPrevious;
    data['hasNext'] = hasNext;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  int? serviceId;
  String? serviceName;
  String? categoryName;
  String? dateFrom;
  String? dateTo;
  String? statusStr;
  bool? autoReply;
  bool? isActive;

  Service(
      {this.serviceId,
        this.serviceName,
        this.categoryName,
        this.dateFrom,
        this.dateTo,
        this.statusStr,
        this.autoReply,
        this.isActive});

  Service.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    categoryName = json['categoryName'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    statusStr = json['statusStr'];
    autoReply = json['autoReply'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['serviceName'] = this.serviceName;
    data['categoryName'] = this.categoryName;
    data['dateFrom'] = this.dateFrom;
    data['dateTo'] = this.dateTo;
    data['statusStr'] = this.statusStr;
    data['autoReply'] = this.autoReply;
    data['isActive'] = this.isActive;
    return data;
  }
}

