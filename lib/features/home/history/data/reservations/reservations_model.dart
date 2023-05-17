class ReservationsResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  ReservationsResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  ReservationsResponse.fromJson(Map<String, dynamic> json) {
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
  List<ReservationModel>? results;

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
      results = <ReservationModel>[];
      json['results'].forEach((v) {
        results!.add(ReservationModel.fromJson(v));
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

class ReservationModel {
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
  bool? userHasInsurance;
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
  String? periodStartTime;
  String? insuranceStatusStr;
  String? periodEndTime;
  String? bookingTypeStr;
  int? bookingTypeId;
  String? offerDate;
  String? userMobile;

  ReservationModel(
      {this.id,
      this.requestId,
      this.providerId,
      this.providerName,
      this.providerMobileStr,
      this.providerLocation,
      this.providerLatitude,
      this.userHasInsurance,
      this.providerLongitude,
      this.insuranceStatusStr,
      this.providerBranchName,
      this.price,
      this.isUnderNegotiation,
      this.isConfirmed,
      this.periodStartTime,
      this.periodId,
      this.branchId,
      this.categoryStr,
      this.providerServiceId,
      this.serviceStr,
      this.userId,
      this.userName,
      this.periodEndTime,
      this.offerDate,
      this.bookingStatusId,
      this.bookingTypeStr,
      this.distanceInMeter,
      this.userMobile,
      this.bookingTypeId,
      this.bookingStatusStr});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    providerId = json['providerId'];
    providerName = json['providerName'];
    providerMobileStr = json['providerMobileStr'];
    providerLocation = json['providerLocation'];
    periodStartTime = json['periodStartTime'];
    periodEndTime = json['periodEndTime'];
    offerDate = json['offerDate'];
    providerLatitude = json['providerLatitude'];
    insuranceStatusStr = json['insuranceStatusStr'];
    userHasInsurance = json['userHasInsurance'];
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
    bookingTypeId = json['bookingTypeId'];
    bookingStatusStr = json['bookingStatusStr'];
    bookingTypeStr = json['bookingTypeStr'];
    userMobile = json['userMobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['requestId'] = requestId;
    data['providerId'] = providerId;
    data['providerName'] = providerName;
    data['providerMobileStr'] = providerMobileStr;
    data['userHasInsurance'] = userHasInsurance;
    data['userMobile'] = userMobile;
    data['bookingTypeId'] = bookingTypeId;
    data['providerLocation'] = providerLocation;
    data['periodStartTime'] = periodStartTime;
    data['periodEndTime'] = periodEndTime;
    data['bookingTypeStr'] = bookingTypeStr;
    data['offerDate'] = offerDate;
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

  String exportToQr() {
    final Map<String, dynamic> data = {};
    data['Reservation Id'] = id;
    data['insurance Status'] = insuranceStatusStr;
    data['user Mobile'] = userMobile;
    data['Start Time'] = periodStartTime;
    data['End Time'] = periodEndTime;
    data['reservation Date'] = offerDate;
    data['Branch Name'] = providerBranchName;
    data['Price'] = price;
    data['Service'] = serviceStr;
    data['user Name'] = userName;
    data['booking Type'] = bookingTypeStr;
    return _formatToQrView(data);
  }

  String _formatToQrView(Map<String, dynamic> data) {
    return '''
    booking Type : ${data['booking Type']} \n
    Reservation Id : ${data['Reservation Id']} \n
    insurance Status : ${data['insurance Status']} \n
    user Name : ${data['user Name']} \n
    user Mobile : ${data['user Mobile']} \n
    Service : ${data['Service']} \n
    Price : ${data['Price']} \n
    Start Time : ${data['Start Time']} \n
    End Time : ${data['End Time']} \n
    Branch Name : ${data['Branch Name']} \n
    reservation Date : ${data['reservation Date']} \n
        ''';
  }
}
