import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pilot_log/src/screens/EditLogbookEntry/EditLogbookEntry.dart';
import 'package:pilot_log/src/screens/ItemFeed/ItemFeed.dart';
import 'package:pilot_log/src/screens/LogbookEntryDetails/LogbookEntryDetails.dart';
import 'package:pilot_log/src/screens/Onboarding/OnboardingRoutes.dart';

class FlutterAppRoutes {
  static const String logbookEntryDetails = 'itemDetails';
  static const String logbookEntryFeed = 'itemFeed';
  static const String welcome = 'welcome';
  static const String onboarding = 'onboarding';
  static const String logbookEntryEdit = 'itemEdit';
}

typedef Route CurriedRouter(RouteSettings settings);

class Router {
  static _pageRoute(Widget widget, String routeName) {
    return MaterialPageRoute(
        builder: (context) => widget, settings: RouteSettings(name: routeName));
  }

  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case FlutterAppRoutes.onboarding:
        return _pageRoute(OnboardingRoutes(), FlutterAppRoutes.onboarding);
      case FlutterAppRoutes.logbookEntryDetails:
        final LogbookEntryDetailsArguments args = settings.arguments;
        return _pageRoute(LogbookEntryDetails(args.logbookEntry), FlutterAppRoutes.logbookEntryDetails);
      case FlutterAppRoutes.logbookEntryFeed:
        return _pageRoute(LogbookEntryFeed(), FlutterAppRoutes.logbookEntryFeed);
      case FlutterAppRoutes.logbookEntryEdit:
        final EditLogbookEntryArgs args = settings.arguments;
        return _pageRoute(
            EditLogbookEntry(logbookEntry: args?.logbookEntry), FlutterAppRoutes.logbookEntryEdit);
      default:
        return _pageRoute(OnboardingRoutes(), FlutterAppRoutes.onboarding);
    }
  }
}
