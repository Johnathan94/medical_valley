class BookRequestModel {
  int? userId;
  int? categoryId;
  String? serviceId;
  int? bookingTypeId;
  String? appointmentDate;
  String? appointmentTime;
  String? notes;
  bool? isProviderService;

  BookRequestModel(
      {this.userId,
      this.categoryId,
      this.serviceId,
      this.bookingTypeId,
      this.appointmentDate,
      this.appointmentTime,
      this.isProviderService,
      this.notes});

  BookRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    categoryId = json['categoryId'];
    serviceId = json['serviceId'];
    bookingTypeId = json['bookingTypeId'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    isProviderService = json['isProviderService'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['categoryId'] = categoryId;
    data['serviceId'] = serviceId;
    data['bookingTypeId'] = bookingTypeId;
    data['appointmentDate'] = appointmentDate;
    data['appointmentTime'] = appointmentTime;
    data['isProviderService'] = isProviderService;
    data['notes'] = notes;
    return data;
  }
}
