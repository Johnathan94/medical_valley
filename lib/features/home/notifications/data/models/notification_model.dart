class NotificationResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  List<NotificationModel>? data;

  NotificationResponse(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add( NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['messageCode'] = messageCode;
    data['responseCode'] = responseCode;
    data['validationIssue'] = validationIssue;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationModel {
  String? englishText;
  String? arabicText;
  int? userId;
  String? userName;
  int? providerId;
  String? providerName;
  int? notificationActionId;
  String? notificationActionStr;
  int? requestId;
  int? offerId;

  NotificationModel(
      {this.englishText,
        this.arabicText,
        this.userId,
        this.userName,
        this.providerId,
        this.providerName,
        this.notificationActionId,
        this.notificationActionStr,
        this.requestId,
        this.offerId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    englishText = json['englishText'];
    arabicText = json['arabicText'];
    userId = json['userId'];
    userName = json['userName'];
    providerId = json['providerId'];
    providerName = json['providerName'];
    notificationActionId = json['notificationActionId'];
    notificationActionStr = json['notificationActionStr'];
    requestId = json['requestId'];
    offerId = json['offerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['englishText'] = englishText;
    data['arabicText'] = arabicText;
    data['userId'] = userId;
    data['userName'] = userName;
    data['providerId'] = providerId;
    data['providerName'] = providerName;
    data['notificationActionId'] = notificationActionId;
    data['notificationActionStr'] = notificationActionStr;
    data['requestId'] = requestId;
    data['offerId'] = offerId;
    return data;
  }
}
