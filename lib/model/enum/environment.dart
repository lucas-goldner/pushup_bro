import 'package:flutter/material.dart';

enum Environment {
  dev,
  prod,
}

extension FlavorTypeExtension on Environment {
  Color? getFlavorColor() {
    switch (this) {
      case Environment.dev:
        return Colors.yellow[800];
      case Environment.prod:
        return Colors.grey[600];
    }
  }

  String getFlavorName() {
    switch (this) {
      case Environment.dev:
        return 'dev';
      case Environment.prod:
        return 'prod';
    }
  }
}
