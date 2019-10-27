import 'package:flutter/material.dart';
import 'package:pilot_log/src/blocs/editItem/bloc.dart';
import 'package:pilot_log/src/models/Item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditLogbookEntryArgs {
  LogbookEntry logbookEntry;

  EditLogbookEntryArgs({this.logbookEntry});
}

class EditLogbookEntry extends StatefulWidget {
  final LogbookEntry logbookEntry;
  EditLogbookEntry({LogbookEntry logbookEntry}) : this.logbookEntry = logbookEntry ?? LogbookEntry();
  @override
  State<StatefulWidget> createState() {
    return _EditLogbookEntryState(logbookEntry: this.logbookEntry);
  }
}

class _EditLogbookEntryState extends State<EditLogbookEntry> {
  LogbookEntry logbookEntry;
  final EditLogbookEntryBloc _editItemBloc = EditLogbookEntryBloc();
  _EditLogbookEntryState({this.logbookEntry});
  initState() {
    super.initState();
  }

  dispose() {
    _editItemBloc.close();
    super.dispose();
  }

  build(_) {
    return BlocBuilder(
        bloc: _editItemBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Entry'),
            ),
            body: SafeArea(
              child: state is LogbookEntryLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      children: <Widget>[
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: logbookEntry.title,
                          decoration: InputDecoration(labelText: 'Item Title'),
                          onChanged: (t) {
                            logbookEntry.title = t;
                          },
                        ),
                        TextFormField(
                          initialValue: logbookEntry.description,
                          decoration:
                              InputDecoration(labelText: 'Item Description'),
                          onChanged: (t) {
                            logbookEntry.description = t;
                          },
                        ),
                        TextFormField(
                          initialValue: logbookEntry.photoUrl,
                          decoration: InputDecoration(labelText: 'Photo Url'),
                          onChanged: (t) {
                            logbookEntry.photoUrl = t;
                          },
                        ),
                        RaisedButton(
                          onPressed: () {
                            _editItemBloc.add(SaveLogbookEntry(logbookEntry));
                          },
                          child: Text('Submit'),
                        )
                      ],
                    ),
            ),
          );
        });
  }
}
