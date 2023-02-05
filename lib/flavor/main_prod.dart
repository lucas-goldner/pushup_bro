import 'package:flutter/material.dart';
import 'package:pushup_bro/flavor/flavor.dart';
import 'package:pushup_bro/main.dart';
import 'package:pushup_bro/model/enum/environment.dart';

void main() async {
  Flavor.setEnvironment(Environment.prod);
  runApp(const Main());
}
