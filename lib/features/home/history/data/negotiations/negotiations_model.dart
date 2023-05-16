class NegotiationsResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  NegotiationsResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  NegotiationsResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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

class Data {
  int? currentPage;
  int? totalPages;
  int? pageSize;
  int? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  List<NegotiationModel>? results;

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
      results = <NegotiationModel>[];
      json['results'].forEach((v) {
        results!.add(NegotiationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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

class NegotiationModel {
  int? id;
  int? requestId;
  int? providerId;
  String? providerName;
  String? providerMobileStr;
  String? providerLocation;
  double? providerLatitude;
  double? providerLongitude;
  String? providerBranchName;
  double? price;
  bool? isUnderNegotiation;
  bool? isConfirmed;
  int? periodId;
  int? branchId;
  String? categoryStr;
  int? providerServiceId;
  String? serviceStr;
  int? userId;
  String? userName;
  int? bookingStatusId;
  String? bookingStatusStr;
  String? distanceInMeter;

  NegotiationModel(
      {this.id,
      this.requestId,
      this.providerId,
      this.providerName,
      this.providerMobileStr,
      this.providerLocation,
      this.providerLatitude,
      this.providerLongitude,
      this.providerBranchName,
      this.price,
      this.isUnderNegotiation,
      this.isConfirmed,
      this.periodId,
      this.branchId,
      this.categoryStr,
      this.providerServiceId,
      this.serviceStr,
      this.userId,
      this.userName,
      this.bookingStatusId,
      this.distanceInMeter,
      this.bookingStatusStr});

  NegotiationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    providerId = json['providerId'];
    providerName = json['providerName'];
    providerMobileStr = json['providerMobileStr'];
    providerLocation = json['providerLocation'];
    providerLatitude = json['providerLatitude'];
    providerLongitude = json['providerLongitude'];
    providerBranchName = json['providerBranchName'];
    price = json['price'];
    isUnderNegotiation = json['isUnderNegotiation'];
    isConfirmed = json['isConfirmed'];
    periodId = json['periodId'];
    branchId = json['branchId'];
    categoryStr = json['categoryStr'];
    providerServiceId = json['providerServiceId'];
    serviceStr = json['serviceStr'];
    userId = json['userId'];
    userName = json['userName'];
    bookingStatusId = json['bookingStatusId'];
    bookingStatusStr = json['bookingStatusStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['requestId'] = requestId;
    data['providerId'] = providerId;
    data['providerName'] = providerName;
    data['providerMobileStr'] = providerMobileStr;
    data['providerLocation'] = providerLocation;
    data['providerLatitude'] = providerLatitude;
    data['providerLongitude'] = providerLongitude;
    data['providerBranchName'] = providerBranchName;
    data['price'] = price;
    data['isUnderNegotiation'] = isUnderNegotiation;
    data['isConfirmed'] = isConfirmed;
    data['periodId'] = periodId;
    data['branchId'] = branchId;
    data['categoryStr'] = categoryStr;
    data['providerServiceId'] = providerServiceId;
    data['serviceStr'] = serviceStr;
    data['userId'] = userId;
    data['userName'] = userName;
    data['bookingStatusId'] = bookingStatusId;
    data['bookingStatusStr'] = bookingStatusStr;
    return data;
  }
}
