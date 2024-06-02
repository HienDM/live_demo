import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_demo/ui/CreateLive/create_live.dart';
import 'package:live_demo/ui/WatchLive/watch_live.dart';

enum AppRoute { CREATELIVE_SCREEN, WATCHLIVE_SCREEN }

extension AppRouteExt on AppRoute {
  String get name {
    switch (this) {
      case AppRoute.CREATELIVE_SCREEN:
        return '/CreateLive';
      case AppRoute.WATCHLIVE_SCREEN:
        return '/WatchLive';
    }
  }

  static AppRoute? from(String? name) {
    for (final item in AppRoute.values) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  static Route generateRoute(RouteSettings settings) {
    switch (AppRouteExt.from(settings.name)) {
      case AppRoute.CREATELIVE_SCREEN:
        return GetPageRoute(
            settings: settings,
            page: () => const CreateLiveScreen(),
            bindings: [
              // BindingsBuilder.put(() => SplashCubit()),
            ],
            curve: Curves.ease,
            transition: Transition.fade);
      case AppRoute.WATCHLIVE_SCREEN:
        return GetPageRoute(
            settings: settings,
            page: () => const WatchLiveScreen(),
            bindings: [
              // BindingsBuilder.put(() => SplashCubit()),
            ],
            curve: Curves.ease,
            transition: Transition.fade);
      default:
        return GetPageRoute(
            settings: settings,
            curve: Curves.linear,
            transition: Transition.rightToLeft
            // page: () => EmptyScreen(desc: 'No route defined for ${settings.name}'),
            );
    }
  }

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route<dynamic> bindingRoute(RouteSettings settings) {
    return AppRouteExt.generateRoute(settings);
  }
}
