import 'dart:convert';

class TeamInfo {
  int id;
  int? teamId;
  int? memberId;
  TeamInfo({
    required this.id,
    this.teamId,
    this.memberId,
  });

  TeamInfo copyWith({
    int? id,
    int? teamId,
    int? memberId,
  }) {
    return TeamInfo(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      memberId: memberId ?? this.memberId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    if (teamId != null) {
      result.addAll({'teamId': teamId});
    }
    if (memberId != null) {
      result.addAll({'memberId': memberId});
    }

    return result;
  }

  factory TeamInfo.fromMap(Map<String, dynamic> map) {
    return TeamInfo(
      id: map['id']?.toInt() ?? 0,
      teamId: map['teamId']?.toInt(),
      memberId: map['memberId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamInfo.fromJson(String source) =>
      TeamInfo.fromMap(json.decode(source));

  @override
  String toString() =>
      'TeamInfo(id: $id, teamId: $teamId, memberId: $memberId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamInfo &&
        other.id == id &&
        other.teamId == teamId &&
        other.memberId == memberId;
  }

  @override
  int get hashCode => id.hashCode ^ teamId.hashCode ^ memberId.hashCode;
}
