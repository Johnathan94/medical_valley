import 'package:flutter/material.dart';

class CustomDropDown<T extends Object> extends StatelessWidget {
  final T value ;
  final List<DropdownMenuItem<T>> items ;
  final Function (T?) onChanged ;
  final Widget? hint ;
  const CustomDropDown(this.value,this.items,this.onChanged,{this.hint ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
        value: value,
        items: items,
        hint: hint,

        onChanged: onChanged,
      elevation: 0,
      isExpanded : true,
        underline:const SizedBox(),
      alignment: Alignment.bottomCenter,
    );
  }
}
