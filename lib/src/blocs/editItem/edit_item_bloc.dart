import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pilot_log/src/repositories/items/itemRepository.dart';
import './bloc.dart';

class EditLogbookEntryBloc extends Bloc<EditLogbookEntryEvent, EditLogbookEntryState> {
  final LogbookEntryRepository _logbookEntryRepository;

  EditLogbookEntryBloc({LogbookEntryRepository logbookEntryRepository})
      : this._logbookEntryRepository = logbookEntryRepository ?? LogbookEntryRepository();

  @override
  EditLogbookEntryState get initialState => InitialLogbookEntryState();

  @override
  Stream<EditLogbookEntryState> mapEventToState(
    EditLogbookEntryEvent event,
  ) async* {
    if (event is SaveLogbookEntry) {
      try {
        yield LogbookEntryLoading();
        final item = await _logbookEntryRepository.saveLogbookEntry(event.logbookEntry);
        yield LogbookEntrySaved(item);
      } catch (e) {
        print(e);
        yield LogbookEntrySaveError();
      }
    }
  }
}
