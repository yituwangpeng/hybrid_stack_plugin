import 'package:flutter/material.dart';
import 'package:hybrid_stack_plugin/hybrid_stack_manager_plugin.dart';

import 'fdemo.dart';
import 'newfdemo.dart';

class AppConfig {
  static final AppConfig _singleton = new AppConfig._internal();
  static final GlobalKey gHomeItemPageWidgetKey =
  new GlobalKey(debugLabel: "[KWLM]");
  static AppConfig sharedInstance() {
    Router.sharedInstance().globalKeyForRouter = gHomeItemPageWidgetKey;
    Router.sharedInstance().routerWidgetHandler =
        ({RouterOption routeOption, Key key}) {
      if (routeOption.url == "hrd://fdemo") {
        return new FDemoWidget(routeOption, key: key);
      }
      if (routeOption.url == "hrd://newfdemo") {
        return new NewFDemoWidget(routeOption, key: key);
      }
      return null;
    };
    return _singleton;
  }

  AppConfig._internal() {}
}
