import 'package:flutter/material.dart';
import 'package:pilot_log/src/blocs/authentication/authentication_state.dart';
import 'package:pilot_log/src/blocs/authentication/bloc.dart';
import 'package:pilot_log/src/services/localizations/localizations.dart';
import 'package:pilot_log/src/services/navigator.dart';
import 'package:pilot_log/src/services/routes.dart';
import 'package:pilot_log/src/theme/theme.dart';
import 'package:pilot_log/src/widgets/BlocProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pilot_log/src/blocs/localization/bloc.dart';

class FlutterApp extends StatelessWidget {
  build(_) {
    return AppBlocProviders(child: Builder(builder: (outerContext) {
      return BlocListener<AuthenticationBloc, AuthenticationState>(
        condition: (prev, curr) {
          if (prev is Uninitialized && curr is Authenticated) {
            return true;
          }
          if (prev is Authenticated && curr is Unauthenticated) {
            return true;
          }
          return false;
        },
        listener: (context, AuthenticationState state) {
          if (state is Authenticated) {
            rootNavigationService.navigateTo(FlutterAppRoutes.logbookEntryFeed);
          } else if (state is Unauthenticated) {
            rootNavigationService.returnToLogin();
          }
        },
        child: BlocBuilder(
            bloc: BlocProvider.of<LocalizationBloc>(outerContext),
            builder: (context, LocalizationState state) {
              return MaterialApp(
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    AppLocalizations.delegate
                  ],
                  locale: state.locale,
                  supportedLocales: AppLocalizations.availableLocalizations
                      .map((item) => Locale(item.languageCode)),
                  theme: flutterAppTheme,
                  home: Navigator(
                      onGenerateRoute: Router.generatedRoute,
                      key: rootNavigationService.navigatorKey));
            }),
      );
    }));
  }
}
