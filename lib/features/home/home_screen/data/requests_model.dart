class RequestsResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  RequestsResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  RequestsResponse.fromJson(Map<String, dynamic> json) {
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
  List<Results>? results;

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
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
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

class Results {
  int? id;
  int? userId;
  String? userName;
  bool? userHasInsurance;
  String? userNationalId;
  int? categoryId;
  String? categoryStr;
  int? providerServiceId;
  String? providerServiceName;
  int? bookingTypeId;
  String? bookingTypeStr;
  String? appointmentDate;
  String? appointmentTime;
  String? notes;
  int? bookingStatusId;
  String? bookingStatusStr;

  Results(
      {this.id,
      this.userId,
      this.userName,
      this.userHasInsurance,
      this.userNationalId,
      this.categoryId,
      this.categoryStr,
      this.providerServiceId,
      this.providerServiceName,
      this.bookingTypeId,
      this.bookingTypeStr,
      this.appointmentDate,
      this.appointmentTime,
      this.notes,
      this.bookingStatusId,
      this.bookingStatusStr});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    userHasInsurance = json['userHasInsurance'];
    userNationalId = json['userNationalId'];
    categoryId = json['categoryId'];
    categoryStr = json['categoryStr'];
    providerServiceId = json['providerServiceId'];
    providerServiceName = json['providerServiceName'];
    bookingTypeId = json['bookingTypeId'];
    bookingTypeStr = json['bookingTypeStr'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    notes = json['notes'];
    bookingStatusId = json['bookingStatusId'];
    bookingStatusStr = json['bookingStatusStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userHasInsurance'] = userHasInsurance;
    data['userNationalId'] = userNationalId;
    data['categoryId'] = categoryId;
    data['categoryStr'] = categoryStr;
    data['providerServiceId'] = providerServiceId;
    data['providerServiceName'] = providerServiceName;
    data['bookingTypeId'] = bookingTypeId;
    data['bookingTypeStr'] = bookingTypeStr;
    data['appointmentDate'] = appointmentDate;
    data['appointmentTime'] = appointmentTime;
    data['notes'] = notes;
    data['bookingStatusId'] = bookingStatusId;
    data['bookingStatusStr'] = bookingStatusStr;
    return data;
  }
}
