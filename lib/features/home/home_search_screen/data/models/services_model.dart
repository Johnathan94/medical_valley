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
  int? id;
  String? englishName;
  String? arabicName;
  double? price;
  String? dateFrom;
  String? dateTo;
  int? discount1;
  int? discount2;
  int? discount3;
  String? description;
  int? statusId;
  bool? autoReply;
  String? statusStr;
  bool? isActive;
  List<String>? serviceDays;
  int? serviceEstTimeInMin;
  int? categoryId;
  String? categoryStr;
  int? userId;
  String? providerStr;
  bool? isProviderService;
  List<String>? providerServices;

  Service(
      {this.id,
        this.englishName,
        this.arabicName,
        this.price,
        this.dateFrom,
        this.dateTo,
        this.discount1,
        this.discount2,
        this.discount3,
        this.description,
        this.statusId,
        this.autoReply,
        this.statusStr,
        this.isActive,
        this.serviceDays,
        this.serviceEstTimeInMin,
        this.categoryId,
        this.categoryStr,
        this.isProviderService,
        this.userId,
        this.providerStr,
        this.providerServices});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    englishName = json['englishName'];
    arabicName = json['arabicName'];
    price = json['price'];
    dateFrom = json['dateFrom'];
    isProviderService = json['isProviderService'];
    dateTo = json['dateTo'];
    discount1 = json['discount1'];
    discount2 = json['discount2'];
    discount3 = json['discount3'];
    description = json['description'];
    statusId = json['statusId'];
    autoReply = json['autoReply'];
    statusStr = json['statusStr'];
    isActive = json['isActive'];
    if (json['serviceDays'] != null) {
      serviceDays = <String>[];
      json['serviceDays'].forEach((v) {
        serviceDays!.add( v);
      });
    }
    serviceEstTimeInMin = json['serviceEstTimeInMin'];
    categoryId = json['categoryId'];
    categoryStr = json['categoryStr'];
    userId = json['userId'];
    providerStr = json['providerStr'];
    if (json['providerServices'] != null) {
      providerServices = <String>[];
      json['providerServices'].forEach((v) {
        providerServices!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['id'] = id;
    data['englishName'] = englishName;
    data['arabicName'] = arabicName;
    data['price'] = price;
    data['dateFrom'] = dateFrom;
    data['dateTo'] = dateTo;
    data['discount1'] = discount1;
    data['discount2'] = discount2;
    data['discount3'] = discount3;
    data['description'] = description;
    data['statusId'] = statusId;
    data['autoReply'] = autoReply;
    data['statusStr'] = statusStr;
    data['isProviderService'] = isProviderService;
    data['isActive'] = isActive;
    if (serviceDays != null) {
      data['serviceDays'] = serviceDays!.map((v) => v).toList();
    }
    data['serviceEstTimeInMin'] = serviceEstTimeInMin;
    data['categoryId'] = categoryId;
    data['categoryStr'] = categoryStr;
    data['userId'] = userId;
    data['providerStr'] = providerStr;
    if (providerServices != null) {
      data['providerServices'] =
          providerServices!.map((v) => v).toList();
    }
    return data;
  }
}
