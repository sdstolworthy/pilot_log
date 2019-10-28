import 'dart:convert';

class Aircraft {
  String registration;
  String aircraftType;
  String aircraftClass;
  Aircraft({
    this.registration,
    this.aircraftType,
    this.aircraftClass,
  });

  Aircraft copyWith({
    String registration,
    String aircraftType,
    String aircraftClass,
  }) {
    return Aircraft(
      registration: registration ?? this.registration,
      aircraftType: aircraftType ?? this.aircraftType,
      aircraftClass: aircraftClass ?? this.aircraftClass,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'registration': registration,
      'aircraftType': aircraftType,
      'aircraftClass': aircraftClass,
    };
  }

  static Aircraft fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return Aircraft(
      registration: map['registration'],
      aircraftType: map['aircraftType'],
      aircraftClass: map['aircraftClass'],
    );
  }

  String toJson() => json.encode(toMap());

  static Aircraft fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'Aircraft registration: $registration, aircraftType: $aircraftType, aircraftClass: $aircraftClass';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Aircraft &&
        o.registration == registration &&
        o.aircraftType == aircraftType &&
        o.aircraftClass == aircraftClass;
  }

  @override
  int get hashCode =>
      registration.hashCode ^ aircraftType.hashCode ^ aircraftClass.hashCode;
}

class UndefinedAircraft extends Aircraft {
  final registration = 'undefined';
}
