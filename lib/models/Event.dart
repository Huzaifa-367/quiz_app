import 'dart:convert';

class eventss {
  int id;
  String dates;
  String type;
  int? Tteams;
  String status;
  eventss({
    required this.id,
    required this.dates,
    required this.type,
    this.Tteams,
    required this.status,
  });

  eventss copyWith({
    int? id,
    String? dates,
    String? type,
    int? Tteams,
    String? status,
  }) {
    return eventss(
      id: id ?? this.id,
      dates: dates ?? this.dates,
      type: type ?? this.type,
      Tteams: Tteams ?? this.Tteams,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'dates': dates});
    result.addAll({'type': type});
    if (Tteams != null) {
      result.addAll({'Tteams': Tteams});
    }
    result.addAll({'status': status});

    return result;
  }

  factory eventss.fromMap(Map<String, dynamic> map) {
    return eventss(
      id: map['id']?.toInt() ?? 0,
      dates: map['dates'] ?? '',
      type: map['type'] ?? '',
      Tteams: map['Tteams']?.toInt(),
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory eventss.fromJson(String source) =>
      eventss.fromMap(json.decode(source));

  @override
  String toString() {
    return 'eventss(id: $id, dates: $dates, type: $type, Tteams: $Tteams, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is eventss &&
        other.id == id &&
        other.dates == dates &&
        other.type == type &&
        other.Tteams == Tteams &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dates.hashCode ^
        type.hashCode ^
        Tteams.hashCode ^
        status.hashCode;
  }
}
