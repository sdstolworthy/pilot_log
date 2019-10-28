import 'dart:convert';

abstract class ApproachType {
  final type = '';
  static fromMap(Map<String, String> map) {
    return allApproaches.firstWhere((e) => e.type == map['type']);
  }

  toMap() {
    return {'type': type};
  }

  const ApproachType();
}

class ILSApproach extends ApproachType {
  final type = 'ils';
  const ILSApproach();
}

class VORApproach extends ApproachType {
  final type = 'vor';
  const VORApproach();
}

class NDBApproach extends ApproachType {
  final type = 'ndb';
  const NDBApproach();
}

class LOCApproach extends ApproachType {
  final type = 'loc';
  const LOCApproach();
}

class RadarApproach extends ApproachType {
  final type = 'radar';
  const RadarApproach();
}

class SDFApproach extends ApproachType {
  final type = 'sdf';
  const SDFApproach();
}

class RNAVApproach extends ApproachType {
  final type = 'rnav';
  const RNAVApproach();
}

final allApproaches = <ApproachType>[
  const ILSApproach(),
  const RNAVApproach(),
  const SDFApproach(),
  const RadarApproach(),
  const LOCApproach(),
  const NDBApproach(),
  const VORApproach(),
];

class InstrumentApproach {
  ApproachType approachType;
  InstrumentApproach({
    this.approachType,
  });

  InstrumentApproach copyWith({
    ApproachType approachType,
  }) {
    return InstrumentApproach(
      approachType: approachType ?? this.approachType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'approachType': approachType.toMap(),
    };
  }

  static InstrumentApproach fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InstrumentApproach(
      approachType: ApproachType.fromMap(map['approachType']),
    );
  }

  String toJson() => json.encode(toMap());

  static InstrumentApproach fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'InstrumentApproach approachType: $approachType';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is InstrumentApproach && o.approachType == approachType;
  }

  @override
  int get hashCode => approachType.hashCode;
}
