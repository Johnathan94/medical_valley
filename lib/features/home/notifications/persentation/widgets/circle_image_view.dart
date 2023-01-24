import 'package:flutter/material.dart';

class CircleImageView extends StatelessWidget {
  final String url ;
  final double width , height ;

   const CircleImageView({required this.url,required this.width,required this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:  BoxDecoration(
          shape: BoxShape.circle,
          image:
      DecorationImage(image: NetworkImage(url),fit: BoxFit.cover,)),
    );
  }
}
