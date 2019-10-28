import 'package:flutter/material.dart';
import 'package:pilot_log/src/blocs/itemFeed/bloc.dart';
import 'package:pilot_log/src/repositories/items/itemRepository.dart';
import 'package:pilot_log/src/screens/LogbookEntryDetails/LogbookEntryDetails.dart';
import 'package:pilot_log/src/services/navigator.dart';
import 'package:pilot_log/src/services/routes.dart';
import 'package:pilot_log/src/widgets/AppDrawer/drawer.dart';
import 'package:pilot_log/src/widgets/LogbookEntryCard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogbookEntryFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogbookEntryFeedState();
  }
}

class _LogbookEntryFeedState extends State<LogbookEntryFeed> {
  // final items = List.generate(20, (_) => Item.random());
  LogbookEntryBloc _logbookEntryBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    _logbookEntryBloc =
        LogbookEntryBloc(logbookEntryRepository: LogbookEntryRepository());
    super.initState();
  }

  build(context) {
    final theme = Theme.of(context);
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            rootNavigationService.navigateTo(
              FlutterAppRoutes.logbookEntryEdit,
            );
          },
          child: Icon(Icons.edit),
        ),
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.color,
          textTheme: theme.appBarTheme.textTheme,
          leading: FlatButton(
            child: Icon(Icons.menu, color: theme.appBarTheme.iconTheme.color),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
        drawer: AppDrawer(),
        body: BlocBuilder<LogbookEntryBloc, LogbookEntryState>(
          bloc: _logbookEntryBloc,
          builder: (context, state) {
            if (state is LogbookEntriesUnloaded) {
              _logbookEntryBloc.add(FetchItems());
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LogbookEntriesFetched) {
              return SafeArea(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return LogbookEntryCard(
                    logbookEntry: state.logbookEntries[index],
                    onPressed: () {
                      rootNavigationService.navigateTo(
                          FlutterAppRoutes.logbookEntryDetails,
                          arguments: LogbookEntryDetailsArguments(
                              logbookEntry: state.logbookEntries[index]));
                    },
                  );
                },
                itemCount: state.logbookEntries.length,
              ));
            }
            return Container();
          },
        ));
  }
}
