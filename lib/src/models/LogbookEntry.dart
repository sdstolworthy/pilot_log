import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:pilot_log/src/models/Aircraft.dart';
import 'package:pilot_log/src/models/InstrumentApproach.dart';
import 'package:pilot_log/src/models/Photograph.dart';
import 'package:uuid/uuid.dart';

class LogbookEntry {
  String id;
  String departure;
  String destination;
  Aircraft aircraft;
  double groundTraining;
  double dualReceived;
  double pilotInCommand;
  double secondInCommand;
  double day;
  double night;
  double crossCountry;
  double actualInstrument;
  double simulatedInstrument;
  List<InstrumentApproach> instrumentApproaches;
  int dayLandings;
  int nightLandings;
  double totalDuration;
  double hobbsStart;
  double hobbsEnd;
  double tachStart;
  double tachEnd;
  DateTime timeStart;
  DateTime timeEnd;
  List<NetworkPhoto> photographs;

  get title {
    return 'Flight from $departure to $destination on ${DateFormat.yMMMd().format(timeStart).toString()}';
  }

  LogbookEntry({
    id,
    this.departure = '',
    this.destination = '',
    aircraft,
    this.groundTraining = 0.0,
    this.dualReceived = 0.0,
    this.pilotInCommand = 0.0,
    this.secondInCommand = 0.0,
    this.day = 0.0,
    this.night = 0.0,
    this.crossCountry = 0.0,
    this.actualInstrument = 0.0,
    this.simulatedInstrument = 0.0,
    instrumentApproaches,
    this.dayLandings = 0,
    this.nightLandings = 0,
    this.totalDuration = 0.0,
    this.hobbsStart,
    this.hobbsEnd,
    this.tachStart,
    this.tachEnd,
    timeStart,
    this.timeEnd,
    photographs,
  })  : this.aircraft = aircraft ?? UndefinedAircraft(),
        id = id ?? Uuid().v4(),
        timeStart = DateTime.now(),
        this.photographs = photographs ?? [],
        this.instrumentApproaches = instrumentApproaches ?? [];

  LogbookEntry copyWith({
    String id,
    String departure,
    String destination,
    Aircraft aircraft,
    String aviationClass,
    double groundTraining,
    double dualReceived,
    double pilotInCommand,
    double secondInCommand,
    double day,
    double night,
    double crossCountry,
    double actualInstrument,
    double simulatedInstrument,
    List<InstrumentApproach> instrumentApproaches,
    int dayLandings,
    int nightLandings,
    int totalDuration,
    double hobbsStart,
    double hobbsEnd,
    double tachStart,
    double tachEnd,
    DateTime timeStart,
    DateTime timeEnd,
    List<NetworkPhoto> photographs,
  }) {
    return LogbookEntry(
      id: id ?? this.id,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      aircraft: aircraft ?? this.aircraft,
      groundTraining: groundTraining ?? this.groundTraining,
      dualReceived: dualReceived ?? this.dualReceived,
      pilotInCommand: pilotInCommand ?? this.pilotInCommand,
      secondInCommand: secondInCommand ?? this.secondInCommand,
      day: day ?? this.day,
      night: night ?? this.night,
      crossCountry: crossCountry ?? this.crossCountry,
      actualInstrument: actualInstrument ?? this.actualInstrument,
      simulatedInstrument: simulatedInstrument ?? this.simulatedInstrument,
      instrumentApproaches: instrumentApproaches ?? this.instrumentApproaches,
      dayLandings: dayLandings ?? this.dayLandings,
      nightLandings: nightLandings ?? this.nightLandings,
      totalDuration: totalDuration ?? this.totalDuration,
      hobbsStart: hobbsStart ?? this.hobbsStart,
      hobbsEnd: hobbsEnd ?? this.hobbsEnd,
      tachStart: tachStart ?? this.tachStart,
      tachEnd: tachEnd ?? this.tachEnd,
      timeStart: timeStart ?? this.timeStart,
      timeEnd: timeEnd ?? this.timeEnd,
      photographs: photographs ?? this.photographs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'departure': departure,
      'destination': destination,
      'aircraft': aircraft.toMap(),
      'groundTraining': groundTraining,
      'dualReceived': dualReceived,
      'pilotInCommand': pilotInCommand,
      'secondInCommand': secondInCommand,
      'day': day,
      'night': night,
      'crossCountry': crossCountry,
      'actualInstrument': actualInstrument,
      'simulatedInstrument': simulatedInstrument,
      'instrumentApproaches':
          List<dynamic>.from(instrumentApproaches.map((x) => x.toMap())),
      'dayLandings': dayLandings,
      'nightLandings': nightLandings,
      'totalDuration': totalDuration,
      'hobbsStart': hobbsStart,
      'hobbsEnd': hobbsEnd,
      'tachStart': tachStart,
      'tachEnd': tachEnd,
      'timeStart': timeStart.millisecondsSinceEpoch,
      'timeEnd': timeEnd?.millisecondsSinceEpoch,
      'photographs': List<dynamic>.from(photographs.map((x) => x.toMap())),
    };
  }

  static LogbookEntry fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LogbookEntry(
      id: map['id'],
      departure: map['departure'],
      destination: map['destination'],
      aircraft: Aircraft.fromMap(map['aircraft']),
      groundTraining: map['groundTraining'],
      dualReceived: map['dualReceived'],
      pilotInCommand: map['pilotInCommand'],
      secondInCommand: map['secondInCommand'],
      day: map['day'],
      night: map['night'],
      crossCountry: map['crossCountry'],
      actualInstrument: map['actualInstrument'],
      simulatedInstrument: map['simulatedInstrument'],
      instrumentApproaches: map['instrumentApproaches'] != null
          ? List<InstrumentApproach>.from(map['instrumentApproaches']
              ?.map((x) => InstrumentApproach.fromMap(x)))
          : [],
      dayLandings: map['dayLandings'],
      nightLandings: map['nightLandings'],
      totalDuration: map['totalDuration'],
      hobbsStart: map['hobbsStart'],
      hobbsEnd: map['hobbsEnd'],
      tachStart: map['tachStart'],
      tachEnd: map['tachEnd'],
      timeStart: DateTime.fromMillisecondsSinceEpoch(map['timeStart']),
      timeEnd: map['timeEnd'] != null && map['timeEnd'] != ''
          ? DateTime.fromMillisecondsSinceEpoch(map['timeEnd'])
          : null,
      photographs: List<NetworkPhoto>.from(
          map['photographs']?.map((x) => NetworkPhoto.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static LogbookEntry fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'LogbookEntry id: $id, departure: $departure, destination: $destination, aircraft: $aircraft, groundTraining: $groundTraining, dualReceived: $dualReceived, pilotInCommand: $pilotInCommand, secondInCommand: $secondInCommand, day: $day, night: $night, crossCountry: $crossCountry, actualInstrument: $actualInstrument, simulatedInstrument: $simulatedInstrument, instrumentApproaches: $instrumentApproaches, dayLandings: $dayLandings, nightLandings: $nightLandings, totalDuration: $totalDuration, hobbsStart: $hobbsStart, hobbsEnd: $hobbsEnd, tachStart: $tachStart, tachEnd: $tachEnd, timeStart: $timeStart, timeEnd: $timeEnd, photographs: $photographs';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LogbookEntry &&
        o.id == id &&
        o.departure == departure &&
        o.destination == destination &&
        o.aircraft == aircraft &&
        o.groundTraining == groundTraining &&
        o.dualReceived == dualReceived &&
        o.pilotInCommand == pilotInCommand &&
        o.secondInCommand == secondInCommand &&
        o.day == day &&
        o.night == night &&
        o.crossCountry == crossCountry &&
        o.actualInstrument == actualInstrument &&
        o.simulatedInstrument == simulatedInstrument &&
        o.instrumentApproaches == instrumentApproaches &&
        o.dayLandings == dayLandings &&
        o.nightLandings == nightLandings &&
        o.totalDuration == totalDuration &&
        o.hobbsStart == hobbsStart &&
        o.hobbsEnd == hobbsEnd &&
        o.tachStart == tachStart &&
        o.tachEnd == tachEnd &&
        o.timeStart == timeStart &&
        o.timeEnd == timeEnd &&
        o.photographs == photographs;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        departure.hashCode ^
        destination.hashCode ^
        aircraft.hashCode ^
        groundTraining.hashCode ^
        dualReceived.hashCode ^
        pilotInCommand.hashCode ^
        secondInCommand.hashCode ^
        day.hashCode ^
        night.hashCode ^
        crossCountry.hashCode ^
        actualInstrument.hashCode ^
        simulatedInstrument.hashCode ^
        instrumentApproaches.hashCode ^
        dayLandings.hashCode ^
        nightLandings.hashCode ^
        totalDuration.hashCode ^
        hobbsStart.hashCode ^
        hobbsEnd.hashCode ^
        tachStart.hashCode ^
        tachEnd.hashCode ^
        timeStart.hashCode ^
        timeEnd.hashCode ^
        photographs.hashCode;
  }
}
