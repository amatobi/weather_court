import 'package:flutter/material.dart';

///Holds the instances of the environment app variables


class AppConfig extends InheritedWidget {
  const AppConfig({Key? key, 
    required this.appName,
    required this.flavorName,
    required this.baseApi,
    required Widget child,
  }) : super(key: key, child: child);

  final String appName;
  final String flavorName;
  final String baseApi;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

