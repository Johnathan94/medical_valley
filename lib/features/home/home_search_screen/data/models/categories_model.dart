class CategoryResponse {
  bool? succeeded;
  String? message;
  int? responseCode;
  Data? data;

  CategoryResponse({this.succeeded, this.message, this.responseCode, this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
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
  List<CategoryModel>? results;

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
      results = <CategoryModel>[];
      json['results'].forEach((v) {
        results!.add( CategoryModel.fromJson(v));
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

class CategoryModel {
  int? id;
  String? name;
  String? arabicName;
  List<Services>? services;

  CategoryModel({this.id, this.name, this.arabicName, this.services});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    arabicName = json['arabicName'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add( Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['id'] = id;
    data['name'] = name;
    data['arabicName'] = arabicName;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
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
  bool? isActive;
  int? categoryId;
  String? categoryStr;

  Services(
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
        this.isActive,
        this.categoryId,
        this.categoryStr});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    englishName = json['englishName'];
    arabicName = json['arabicName'];
    price = json['price'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    discount1 = json['discount1'];
    discount2 = json['discount2'];
    discount3 = json['discount3'];
    description = json['description'];
    statusId = json['statusId'];
    autoReply = json['autoReply'];
    isActive = json['isActive'];
   
    categoryId = json['categoryId'];
    categoryStr = json['categoryStr'];
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
    data['isActive'] = isActive;
    data['categoryId'] = categoryId;
    data['categoryStr'] = categoryStr;
    return data;
  }
}
