import 'package:pilot_log/src/models/Item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EditLogbookEntryEvent {}

class SaveLogbookEntry extends EditLogbookEntryEvent {
  final LogbookEntry logbookEntry;
  SaveLogbookEntry(this.logbookEntry);
}
