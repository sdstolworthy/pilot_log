import 'package:flutter/widgets.dart';
import 'package:pilot_log/src/blocs/authentication/bloc.dart';
import 'package:pilot_log/src/blocs/localization/bloc.dart';
import 'package:pilot_log/src/repositories/user/userRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Combines application level bloc stores above the rest of the application
class AppBlocProviders extends StatelessWidget {
  final Widget child;
  AppBlocProviders({this.child});
  final AuthenticationBloc authBloc = AuthenticationBloc(new UserRepository());
  Widget build(BuildContext _) {
    authBloc.add(AppStarted());
    return BlocProvider(
        builder: (context) => authBloc,
        child: Builder(builder: (subAuthenticationContext) {
          return MultiBlocProvider(providers: [
            BlocProvider<LocalizationBloc>(
              builder: (_) => LocalizationBloc(),
            )
          ], child: child);
        }));
  }
}
