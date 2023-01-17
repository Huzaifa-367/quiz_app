import 'dart:convert';

class EventDetail {
  int id;
  int? eventId;
  int? teamId;
  EventDetail({
    required this.id,
    this.eventId,
    this.teamId,
  });

  EventDetail copyWith({
    int? id,
    int? eventId,
    int? teamId,
  }) {
    return EventDetail(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      teamId: teamId ?? this.teamId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    if (eventId != null) {
      result.addAll({'eventId': eventId});
    }
    if (teamId != null) {
      result.addAll({'teamId': teamId});
    }

    return result;
  }

  factory EventDetail.fromMap(Map<String, dynamic> map) {
    return EventDetail(
      id: map['id']?.toInt() ?? 0,
      eventId: map['eventId']?.toInt(),
      teamId: map['teamId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventDetail.fromJson(String source) =>
      EventDetail.fromMap(json.decode(source));

  @override
  String toString() =>
      'EventDetail(id: $id, eventId: $eventId, teamId: $teamId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventDetail &&
        other.id == id &&
        other.eventId == eventId &&
        other.teamId == teamId;
  }

  @override
  int get hashCode => id.hashCode ^ eventId.hashCode ^ teamId.hashCode;
}
