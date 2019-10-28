import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilot_log/src/blocs/editItem/bloc.dart';
import 'package:pilot_log/src/blocs/imageHandler/bloc.dart';
import 'package:pilot_log/src/models/LogbookEntry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilot_log/src/models/Photograph.dart';
import 'package:pilot_log/src/services/inputFormatters.dart';
import 'package:pilot_log/src/widgets/ImageUploader.dart';
import 'package:uuid/uuid.dart';

class EditLogbookEntryArgs {
  LogbookEntry logbookEntry;

  EditLogbookEntryArgs({this.logbookEntry});
}

class EditLogbookEntry extends StatefulWidget {
  final LogbookEntry logbookEntry;
  EditLogbookEntry({LogbookEntry logbookEntry})
      : this.logbookEntry = logbookEntry ?? LogbookEntry();
  @override
  State<StatefulWidget> createState() {
    return _EditLogbookEntryState(logbookEntry: this.logbookEntry);
  }
}

class _EditLogbookEntryState extends State<EditLogbookEntry> {
  LogbookEntry logbookEntry;
  final EditLogbookEntryBloc _editItemBloc = EditLogbookEntryBloc();
  final ImageHandlerBloc _imageHandlerBloc = ImageHandlerBloc();
  List<Photograph> images;
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
                          initialValue: logbookEntry.departure,
                          decoration:
                              InputDecoration(labelText: 'Departure Airport'),
                          onChanged: (t) {
                            logbookEntry.departure = t;
                          },
                        ),
                        TextFormField(
                          initialValue: logbookEntry.destination,
                          decoration:
                              InputDecoration(labelText: 'Destination Airport'),
                          onChanged: (t) {
                            logbookEntry.destination = t;
                          },
                        ),
                        TextFormField(
                            initialValue:
                                logbookEntry.pilotInCommand.toString() ??
                                    0.0.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              doubleFormatter
                            ],
                            decoration: InputDecoration(
                                labelText: 'Pilot-in-Command Time')),
                        TextFormField(
                            initialValue:
                                logbookEntry.crossCountry.toString() ??
                                    0.0.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              doubleFormatter
                            ],
                            decoration: InputDecoration(
                                labelText: 'Cross-Country Time')),
                        TextFormField(
                            initialValue:
                                logbookEntry.night.toString() ?? 0.0.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              doubleFormatter
                            ],
                            decoration:
                                InputDecoration(labelText: 'Night Time')),
                        TextFormField(
                            initialValue: logbookEntry.dayLandings.toString() ??
                                0.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration:
                                InputDecoration(labelText: 'Day Landings')),
                        TextFormField(
                            initialValue:
                                logbookEntry.nightLandings.toString() ??
                                    0.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration:
                                InputDecoration(labelText: 'Night Landings')),
                        BlocBuilder<ImageHandlerBloc, ImageHandlerState>(
                            bloc: _imageHandlerBloc,
                            builder: (context, state) {
                              if (state is InitialImageHandlerState) {
                                _imageHandlerBloc.add(SetPhotographs(
                                    logbookEntry.photographs ??
                                        <Photograph>[]));
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is PhotographsLoaded) {
                                return Wrap(
                                    alignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      ...state.photographs.map<Widget>((i) {
                                        if (i is NetworkPhoto) {
                                          return Image.network(
                                            i.imageUrl,
                                            height: 100,
                                            width: 100,
                                          );
                                        } else if (i is FilePhoto) {
                                          return ImageUploader(
                                            i.file,
                                            onComplete: (String imageUrl) {
                                              final newPhoto = NetworkPhoto(
                                                  imageUrl: imageUrl);
                                              _imageHandlerBloc.add(
                                                  ReplaceFilePhotoWithNetworkPhoto(
                                                      photograph: newPhoto,
                                                      filePhotoGuid: i.guid));

                                              logbookEntry.photographs
                                                  .add(newPhoto);
                                            },
                                          );
                                        }
                                        return Container();
                                      }).toList()
                                        ..add(FlatButton(
                                            onPressed: () async {
                                              File file =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (file == null) {
                                                return;
                                              }
                                              final FilePhoto photo =
                                                  new FilePhoto(
                                                      file: file,
                                                      guid: Uuid().v4());
                                              _imageHandlerBloc
                                                  .add(AddPhotograph(photo));
                                            },
                                            child: Container(
                                                color: Colors.grey,
                                                child: SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: Center(
                                                      child: Icon(
                                                          Icons.add_a_photo)),
                                                ))))
                                    ]);
                              }
                            }),
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
