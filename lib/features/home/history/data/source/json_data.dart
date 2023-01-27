import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:medical_valley/features/home/history/data/clinic_model.dart';
class JsonDataSrc {
  Clinics storageData = Clinics();
  Future<Clinics> readJson() async {
    if(storageData.items != null && storageData.items!.isNotEmpty){
      return storageData;
    }
    final String response =
    await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    storageData = Clinics.fromJson(data);
    return storageData;
  }
  Future<void> changePrice(double price) async {
    for(var item in storageData.items!){
      if(item.clinicName == ""){
        item.price = price;
      }
    }
  }

}
