import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:pilot_log/src/models/LogbookEntry.dart';

typedef void OnPressed();

class LogbookEntryCard extends StatelessWidget {
  final LogbookEntry logbookEntry;
  final OnPressed onPressed;
  LogbookEntryCard({@required this.logbookEntry, this.onPressed});
  build(context) {
    final theme = Theme.of(context);
    return Card(
      shape: theme.cardTheme.shape,
      color: theme.cardTheme.color,
      margin: theme.cardTheme.margin,
      child: FlatButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(logbookEntry.title, style: theme.textTheme.headline),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                    child: Image.network('https://via.placeholder.com/70',
                        height: 70),
                  ),
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Text(
                          logbookEntry.title,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
