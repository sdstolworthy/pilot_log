import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:pilot_log/src/repositories/items/itemRepository.dart';
import './bloc.dart';

class LogbookEntryBloc extends Bloc<LogbookEntryEvent, LogbookEntryState> {
  @override
  LogbookEntryState get initialState => LogbookEntriesUnloaded();

  final LogbookEntryRepository logbookEntryRepository;

  LogbookEntryBloc({@required this.logbookEntryRepository});

  @override
  Stream<LogbookEntryState> mapEventToState(
    LogbookEntryEvent event,
  ) async* {
    if (event is FetchItems) {
      final logbookEntries = await logbookEntryRepository.getItems();
      yield LogbookEntriesFetched(logbookEntries);
    }
  }
}
