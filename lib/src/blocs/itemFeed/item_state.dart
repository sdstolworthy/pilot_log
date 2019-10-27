import 'package:pilot_log/src/models/Item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LogbookEntryState {}

class LogbookEntriesUnloaded extends LogbookEntryState {}

class LogbookEntriesFetched extends LogbookEntryState {
  final List<LogbookEntry> logbookEntries;
  LogbookEntriesFetched(this.logbookEntries);
}

class FetchError extends LogbookEntryState {}
