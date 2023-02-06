import 'package:flutter/material.dart';

class DialogsManager {


}
extension ShowSnackBar on BuildContext{
  void showSnackBar (String text){
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(text)));
  }
}