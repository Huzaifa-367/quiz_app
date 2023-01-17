import 'dart:convert';

class eventss {
  int id;
  String dates;
  String type;
  int? tteams;
  String status;
  eventss({
    required this.id,
    required this.dates,
    required this.type,
    this.tteams,
    required this.status,
  });

  eventss copyWith({
    int? id,
    String? dates,
    String? type,
    int? tteams,
    String? status,
  }) {
    return eventss(
      id: id ?? this.id,
      dates: dates ?? this.dates,
      type: type ?? this.type,
      tteams: tteams ?? this.tteams,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'dates': dates});
    result.addAll({'type': type});
    if (tteams != null) {
      result.addAll({'tteams': tteams});
    }
    result.addAll({'status': status});

    return result;
  }

  factory eventss.fromMap(Map<String, dynamic> map) {
    return eventss(
      id: map['id']?.toInt() ?? 0,
      dates: map['dates'] ?? '',
      type: map['type'] ?? '',
      tteams: map['tteams']?.toInt(),
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory eventss.fromJson(String source) =>
      eventss.fromMap(json.decode(source));

  @override
  String toString() {
    return 'eventss(id: $id, dates: $dates, type: $type, tteams: $tteams, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is eventss &&
        other.id == id &&
        other.dates == dates &&
        other.type == type &&
        other.tteams == tteams &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dates.hashCode ^
        type.hashCode ^
        tteams.hashCode ^
        status.hashCode;
  }
}
