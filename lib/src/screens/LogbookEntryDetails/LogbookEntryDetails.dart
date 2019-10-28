import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pilot_log/src/models/LogbookEntry.dart';
import 'package:pilot_log/src/screens/EditLogbookEntry/EditLogbookEntry.dart';
import 'package:pilot_log/src/services/navigator.dart';
import 'package:pilot_log/src/services/routes.dart';

class LogbookEntryDetailsArguments {
  LogbookEntry logbookEntry;

  LogbookEntryDetailsArguments({@required this.logbookEntry});
}

class LogbookEntryDetails extends StatelessWidget {
  final LogbookEntry logbookEntry;
  LogbookEntryDetails(this.logbookEntry);
  build(context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.appBarTheme.color,
          leading: FlatButton(
              child: Icon(Icons.arrow_back,
                  color: theme.appBarTheme.iconTheme.color),
              onPressed: () {
                rootNavigationService.goBack();
              }),
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                rootNavigationService.navigateTo(
                    FlutterAppRoutes.logbookEntryEdit,
                    arguments:
                        EditLogbookEntryArgs(logbookEntry: logbookEntry));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                          child: Text(logbookEntry.title,
                              style: theme.textTheme.display1)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: logbookEntry.photographs != null &&
                            logbookEntry.photographs.length > 0
                        ? CarouselSlider(
                            height: 150,
                            viewportFraction: 0.5,
                            enableInfiniteScroll: false,
                            items: <Widget>[
                              ...logbookEntry.photographs
                                  .map((p) => Image.network(p.imageUrl))
                                  .toList()
                            ],
                          )
                        : Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                          child: Column(
                        children: <Widget>[
                          Text(logbookEntry.title,
                              style: theme.textTheme.subhead),
                        ],
                      )),
                    ],
                  ),
                ],
              )),
        ));
  }
}
