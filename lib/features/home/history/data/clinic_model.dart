class NegotiationsHistoryModel {
  bool? succeeded;
  String? message;
  Null? messageCode;
  int? responseCode;
  Null? validationIssue;
  Data? data;

  NegotiationsHistoryModel(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  NegotiationsHistoryModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['succeeded'] = this.succeeded;
    data['message'] = this.message;
    data['messageCode'] = this.messageCode;
    data['responseCode'] = this.responseCode;
    data['validationIssue'] = this.validationIssue;
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
  List<HistoryItem>? results;

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
      results = <HistoryItem>[];
      json['results'].forEach((v) {
        results!.add(new HistoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['pageSize'] = this.pageSize;
    data['totalCount'] = this.totalCount;
    data['hasPrevious'] = this.hasPrevious;
    data['hasNext'] = this.hasNext;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryItem {
  int? id;
  String? userStr;
  String? categoryStr;
  String? serviceStr;
  String? mobileStr;

  HistoryItem(
      {this.id,
        this.userStr,
        this.categoryStr,
        this.serviceStr,
        this.mobileStr});

  HistoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userStr = json['userStr'];
    categoryStr = json['categoryStr'];
    serviceStr = json['serviceStr'];
    mobileStr = json['mobileStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userStr'] = this.userStr;
    data['categoryStr'] = this.categoryStr;
    data['serviceStr'] = this.serviceStr;
    data['mobileStr'] = this.mobileStr;
    return data;
  }
}
