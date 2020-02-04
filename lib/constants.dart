import 'package:flutter/material.dart';

String prefix = 'https://pixabay.com/api/?key=15000771-9bb9ac0763d9ad28b6694f6d2&q=';
String suffix = '&image_type=photo&page=';

getColor(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark)
    return Colors.white;
  else
    return Colors.black;
}