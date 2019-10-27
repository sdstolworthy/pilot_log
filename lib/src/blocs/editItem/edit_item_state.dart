import 'package:pilot_log/src/models/Item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EditLogbookEntryState {}

class InitialLogbookEntryState extends EditLogbookEntryState {}

class LogbookEntryLoaded extends EditLogbookEntryState {
  final LogbookEntry logbookEntry;
  LogbookEntryLoaded(this.logbookEntry);
}

class LogbookEntrySaved extends EditLogbookEntryState {
  final LogbookEntry item;
  LogbookEntrySaved(this.item);
}

class LogbookEntryLoading extends EditLogbookEntryState {}

class LogbookEntrySaveError extends EditLogbookEntryState {}
