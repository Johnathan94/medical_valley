class PackageResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  PackageModel? data;

  PackageResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  PackageResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? PackageModel.fromJson(json['data']) : null;
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

class PackageModel {
  int? currentPage;
  int? totalPages;
  int? pageSize;
  int? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  List<Package>? results;

  PackageModel(
      {this.currentPage,
      this.totalPages,
      this.pageSize,
      this.totalCount,
      this.hasPrevious,
      this.hasNext,
      this.results});

  PackageModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    hasPrevious = json['hasPrevious'];
    hasNext = json['hasNext'];
    if (json['results'] != null) {
      results = <Package>[];
      json['results'].forEach((v) {
        results!.add(Package.fromJson(v));
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

class Package {
  int? id;
  String? englishName;
  String? arabicName;
  int? categoryId;
  String? categoryStr;
  double? price;
  String? description;
  String? startDate;
  String? expiryDate;
  bool? isActive;
  int? providerId;
  List<PackageServices>? packageServices;

  Package(
      {this.id,
      this.englishName,
      this.arabicName,
      this.categoryId,
      this.categoryStr,
      this.price,
      this.description,
      this.startDate,
      this.expiryDate,
      this.isActive,
      this.providerId,
      this.packageServices});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    englishName = json['englishName'];
    arabicName = json['arabicName'];
    categoryId = json['categoryId'];
    categoryStr = json['categoryStr'];
    price = json['price'];
    description = json['description'];
    startDate = json['startDate'];
    expiryDate = json['expiryDate'];
    isActive = json['isActive'];
    providerId = json['providerId'];
    if (json['packageServices'] != null) {
      packageServices = <PackageServices>[];
      json['packageServices'].forEach((v) {
        packageServices!.add(PackageServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['englishName'] = englishName;
    data['arabicName'] = arabicName;
    data['categoryId'] = categoryId;
    data['categoryStr'] = categoryStr;
    data['price'] = price;
    data['description'] = description;
    data['startDate'] = startDate;
    data['expiryDate'] = expiryDate;
    data['isActive'] = isActive;
    data['providerId'] = providerId;
    if (packageServices != null) {
      data['packageServices'] =
          packageServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageServices {
  int? packageId;
  int? providerServiceId;
  String? providerServiceName;

  PackageServices(
      {this.packageId, this.providerServiceId, this.providerServiceName});

  PackageServices.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
    providerServiceId = json['providerServiceId'];
    providerServiceName = json['providerServiceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['packageId'] = packageId;
    data['providerServiceId'] = providerServiceId;
    data['providerServiceName'] = providerServiceName;
    return data;
  }
}
