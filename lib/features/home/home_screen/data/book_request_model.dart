class BookRequestModel {
  int? userId;
  int? categoryId;
  int? serviceId;
  int? bookingTypeId;
  String? appointmentDate;
  String? appointmentTime;
  String? notes;

  BookRequestModel(
      {
        this.userId,
        this.categoryId,
        this.serviceId,
        this.bookingTypeId,
        this.appointmentDate,
        this.appointmentTime,
        this.notes});

  BookRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    categoryId = json['categoryId'];
    serviceId = json['serviceId'];
    bookingTypeId = json['bookingTypeId'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
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
    data['notes'] = notes;
    return data;
  }
}
